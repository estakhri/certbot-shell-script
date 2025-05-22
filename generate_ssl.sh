#!/bin/bash

# Usage: sudo ./generate_ssl.sh [nginx|apache|general] example.com [www.example.com]

set -e

# Check arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: sudo $0 [nginx|apache|general] yourdomain.com [www.yourdomain.com]"
  exit 1
fi

SERVER_TYPE=$1
shift
DOMAINS=("$@")
EMAIL="admin@${DOMAINS[0]}"
DOMAIN_ARGS=""

# Combine domain args
for d in "${DOMAINS[@]}"; do
  DOMAIN_ARGS="$DOMAIN_ARGS -d $d"
done

# Install certbot and plugin
install_certbot() {
  echo "Installing Certbot and required plugins..."
  apt update
  apt install -y software-properties-common
  add-apt-repository universe -y
  apt update

  apt install -y certbot
  case $SERVER_TYPE in
    nginx)
      apt install -y python3-certbot-nginx
      ;;
    apache)
      apt install -y python3-certbot-apache
      ;;
  esac
}

# Generate certificate
generate_cert() {
  echo "Generating certificate for: ${DOMAINS[*]}"
  case $SERVER_TYPE in
    nginx)
      certbot --nginx $DOMAIN_ARGS --non-interactive --agree-tos --email "$EMAIL"
      ;;
    apache)
      certbot --apache $DOMAIN_ARGS --non-interactive --agree-tos --email "$EMAIL"
      ;;
    general)
      certbot certonly --standalone $DOMAIN_ARGS --non-interactive --agree-tos --email "$EMAIL"
      ;;
    *)
      echo "Unknown server type: $SERVER_TYPE"
      exit 1
      ;;
  esac
}

# Show certificate paths
show_cert_paths() {
  CERT_DIR="/etc/letsencrypt/live/${DOMAINS[0]}"
  echo ""
  echo "✅ Certificate successfully created for ${DOMAINS[0]}"
  echo "🔒 Certificate paths:"
  echo "Private Key:         $CERT_DIR/privkey.pem"
  echo "Certificate:         $CERT_DIR/cert.pem"
  echo "Full Chain:          $CERT_DIR/fullchain.pem"
  echo "Chain:               $CERT_DIR/chain.pem"
}

# Run steps
install_certbot
generate_cert
show_cert_paths
