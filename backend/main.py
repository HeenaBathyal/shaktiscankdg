from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import nmap
import socket
import psutil
import ipaddress

app = FastAPI(title="Shakti Scan")

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

CAMERA_VENDORS = ["Hikvision", "Dahua", "CP Plus", "Axis", "Foscam", "Wyze", "TP-Link", "D-Link"]
CAMERA_PORTS = [80, 554, 8000, 8080]

def calculate_risk(ip, vendor, open_ports, local_ip):
    if ip == local_ip:
        return 0, "Local host (skipped)"
    if vendor and any(cam.lower() in vendor.lower() for cam in CAMERA_VENDORS):
        return 5, "Camera vendor detected"
    if any(port in CAMERA_PORTS for port in open_ports):
        return 3, "Suspicious camera ports open"
    return 0, ""

def get_wifi_network():
    for iface, addrs in psutil.net_if_addrs().items():
        if not any(x in iface.lower() for x in ("wi-fi", "wifi", "wlan")):
            continue
        for addr in addrs:
            if addr.family == socket.AF_INET:
                ip = addr.address
                if ip.startswith("127.") or ip.startswith("169.254."):
                    continue
                try:
                    network = ipaddress.IPv4Network(f"{ip}/{addr.netmask}", strict=False)
                    return {"iface": iface, "ip": ip, "network": str(network)}
                except Exception:
                    pass
    return None

def perform_scan():
    wifi_net = get_wifi_network()
    if not wifi_net:
        return None, []

    ip_range = wifi_net["network"]
    local_ip = wifi_net["ip"]
    iface = wifi_net["iface"]

    nm = nmap.PortScanner()
    nm.scan(hosts=ip_range, arguments="-sn -PR")

    results = []
    for host in nm.all_hosts():
        vendor = "Unknown"
        if 'vendor' in nm[host]:
            vendors = nm[host]['vendor']
            if vendors:
                vendor = list(vendors.values())[0]
        mac_addr = nm[host]['addresses'].get('mac', 'Unknown')
        hostname = nm[host].hostname() or 'Unknown'
        open_ports = [int(port) for port, port_data in nm[host].get("tcp", {}).items() if port_data['state'] == 'open'] if 'tcp' in nm[host] else []

        risk, reason = calculate_risk(host, vendor, open_ports, local_ip)

        results.append({
            "iface": iface,
            "network": ip_range,
            "ip": host,
            "hostname": hostname,
            "mac": mac_addr,
            "vendor": vendor,
            "open_ports": open_ports,
            "risk": risk,
            "status": "Safe" if risk == 0 else "Threat",
            "reason": reason
        })

    return wifi_net, results

@app.get("/scan")
def scan_network():
    wifi_net, devices = perform_scan()
    if wifi_net is None:
        raise HTTPException(status_code=404, detail="Could not detect Wi-Fi network")
    return {"network": wifi_net, "devices": devices}

@app.get("/heatmap")
def heatmap():
    wifi_net, devices = perform_scan()
    if wifi_net is None:
        raise HTTPException(status_code=404, detail="Could not detect Wi-Fi network")
    heatmap_data = [
        {
            "x": idx,
            "y": 1,
            "value": dev["risk"],
            "ip": dev["ip"],
            "hostname": dev["hostname"],
            "status": dev["status"],
            "reason": dev["reason"],
        }
        for idx, dev in enumerate(devices)
    ]
    return {"network": wifi_net, "heatmap": heatmap_data}

def arp_scan(network):
    nm = nmap.PortScanner()
    nm.scan(hosts=network, arguments='-sn -PR')
    devices = []
    for host in nm.all_hosts():
        mac = nm[host]['addresses'].get('mac', 'Unknown')
        vendor = nm[host]['vendor'].get(mac, 'Unknown') if mac != 'Unknown' and 'vendor' in nm[host] else 'Unknown'
        devices.append({"ip": host, "mac": mac, "vendor": vendor})
    return devices

@app.get("/arp_scan/{network}")
def api_arp_scan(network: str):
    try:
        # Validate network input
        ipaddress.ip_network(network)
    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid network format")

    try:
        devices = arp_scan(network)
        return {"devices": devices}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
