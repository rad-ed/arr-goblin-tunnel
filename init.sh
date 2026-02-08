# whole-arr configs
export PUID=$(id -u)
export PGID=$(id -g)


# gluetun configs
# export WIREGUARD_CONFIG_PATH="./goblin-tunnel-US-CA-188.conf"
export OPENVPN_USERNAME="fG2iPUEVCCNKj4nu"
export OPENVPN_PASSWORD="8dnWOnrE97vRHMShvQl5d5s7PmXhXm6B"
export PROTON_USERNAME="maxwell.cudlitz@gmail.com"
export PROTON_PASSWORD="7LBrH7tbDhM6!EJ9"
export GLUETUN_PATH="$HOME/gluetun"
export GLUETUN_CONFIG_PATH="$GLUETUN_PATH/config"

# radaar configs
export RADAAR_PORT="7878"
export RADAAR_PATH="$HOME/radaar"
export RADAAR_CONFIG_PATH="$RADAAR_PATH/config"
export RADAAR_MOVIES_PATH="$RADAAR_PATH/movies"
export RADAAR_DOWNLOADS_PATH="$RADAAR_PATH/downloads"

# other ports
export SONAAR_PORT="8989"
export QBIT_PORT="8080"
export QBIT_LISTEN_PORT="6881"
export TORRENT_PORT="51413"
export SOULSEEK_LISTEN_PORT="2234"
export SOULSEEK_OBFUSCATED_PORT="2235"

# Combine them for the Firewall (Comma-separated, NO spaces)
export WIREGUARD_FIREWALL_PORTS="${TORRENT_PORT},${SOULSEEK_LISTEN_PORT},${SOULSEEK_OBFUSCATED_PORT}"

# initialize paths & perms to PID
for p in ${GLUETUN_CONFIG_PATH} ${RADAAR_CONFIG_PATH} ${RADAAR_MOVIES_PATH} ${RADAAR_DOWNLOADS_PATH}; do
    mkdir -p ${p} && sudo chown -R ${PUID}:${PGID} ${p}
done
# Set permissions using the variables (Portable)
# We use $(id -gn) to get the group name dynamically instead of hardcoding 'staff'
sudo chown -R "${PUID}:${PGID}" "$RADAAR_PATH" "$GLUETUN_PATH"
sudo chmod -R 775 "$RADAAR_PATH" "$GLUETUN_PATH"

docker-compose up
