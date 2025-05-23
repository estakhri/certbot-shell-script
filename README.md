# SSL Certificate Generator with Certbot

This is a simple shell script to automate the installation of Certbot and generation of Let's Encrypt SSL certificates for your domain. It supports **NGINX**, **Apache**, and a **general standalone mode**.

---

## Features

- Checks if Certbot is installed; installs it if missing
- Supports NGINX and Apache plugin installation
- Generates certificates for one or multiple domains
- Prints the paths of the generated certificates
- Fully automated and non-interactive

---

## Requirements

- A Linux server (Debian/Ubuntu tested)
- Root or sudo privileges
- Domain name(s) pointing to the server
- Ports 80 and 443 open on the server firewall

---

## Usage

```bash
chmod +x generate_ssl.sh
sudo ./generate_ssl.sh [nginx|apache|general] yourdomain.com [www.yourdomain.com]
```

### Examples

- For NGINX:
  ```bash
  sudo ./generate_ssl.sh nginx example.com www.example.com
  ```
- For Apache:
  ```bash
  sudo ./generate_ssl.sh apache example.com
  ```
- For standalone (general):
  ```bash
  sudo ./generate_ssl.sh general example.com
  ```

---

## Output

The script will display the paths to:

- Private key: `privkey.pem`
- Certificate: `cert.pem`
- Full certificate chain: `fullchain.pem`
- CA chain: `chain.pem`

Typically located in: `/etc/letsencrypt/live/yourdomain.com/`

---

## Notes

- Ensure your domain DNS records are correctly pointed to this server.
- Standalone mode temporarily runs a web server on port 80, so make sure no other service is using it.
- Certificates issued by Let's Encrypt are valid for 90 days; consider setting up auto-renewal.

---

## License

MIT License © Nima Estakhri

---

## Author

Nima Estakhri — [GitHub](https://github.com/estakhri)
