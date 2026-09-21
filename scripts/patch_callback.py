from pathlib import Path
p = Path("/home/frappe/frappe-bench/apps/ecommerce_integrations/ecommerce_integrations/shopify/connection.py")
s = p.read_text()
needle = 'if frappe.conf.developer_mode and frappe.conf.localtunnel_url:'
replacement = 'if frappe.conf.get("shopify_callback_host"):\n\t\treturn frappe.conf.shopify_callback_host\n\telif frappe.conf.developer_mode and frappe.conf.localtunnel_url:'
if s.count(needle) != 1:
    raise SystemExit("Upstream callback implementation changed; review patch before building")
p.write_text(s.replace(needle, replacement))
