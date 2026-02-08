# whole-arr configs
export PUID=$(id -u)
export PGID=$(id -g)
export MOVIES_PATH="$HOME/movies"
export DOWNLOADS_PATH="$HOME/downloads"

# gluetun configs
# export WIREGUARD_CONFIG_PATH="./goblin-tunnel-US-CA-188.conf"
export OPENVPN_USERNAME="fG2iPUEVCCNKj4nu"
export OPENVPN_PASSWORD="8dnWOnrE97vRHMShvQl5d5s7PmXhXm6B"
export PROTON_USERNAME="maxwell.cudlitz@gmail.com"
export PROTON_PASSWORD="7LBrH7tbDhM6!EJ9"
export GLUETUN_PATH="$HOME/gluetun"
export GLUETUN_CONFIG_PATH="$GLUETUN_PATH/config"

# buildarr configs
export BUILDARR_PORT="7877"
export BUILDARR_PATH="$HOME/buildarr"
export BUILDARR_CONFIG_PATH="$BUILDARR_PATH/config"

# radarr configs
export RADARR_PORT="7878"
export RADARR_SSL_PORT="9898" # unused currently
export RADARR_PATH="$HOME/radarr"
export RADARR_CONFIG_PATH="$RADARR_PATH/config"
# Define your desired 32-character hex key
export RADARR_API_KEY=8B29563564C3D597018A1003B57C1B9C
# Ensure the config directory exists
mkdir -p "$RADARR_CONFIG_PATH"
# Create the config.xml if it doesn't exist
if [ ! -f "$RADARR_CONFIG_PATH/config.xml" ]; then
    cat <<EOF > "$RADARR_CONFIG_PATH/config.xml"
<Config>
  <ApiKey>${RADARR_API_KEY}</ApiKey>
  <AuthenticationMethod>None</AuthenticationMethod>
  <Port>${RADARR_PORT}</Port>
  <UrlBase></UrlBase>
  <BindAddress>*</BindAddress>
  <SslPort>${RADARR_SSL_PORT}</SslPort>
  <EnableSsl>False</EnableSsl>
</Config>
EOF
    echo "Seeded Radarr config with API Key: $RADARR_API_KEY"
fi

# transmission configs
export TRANSMISSION_PEER_PORT="51413"
export TRANSMISSION_UI_PORT="9091"
export TRANSMISSION_PATH="$HOME/transmission"
export TRANSMISSION_CONFIG_PATH="$TRANSMISSION_PATH/config"
export TRANSMISSION_USERNAME="admin"
export TRANSMISSION_PASSWORD="1jij213o1u891729jlajdldhwuajdwhajk"

# other ports
export SONARR_PORT="8989"
export QBIT_PORT="8080"
export QBIT_LISTEN_PORT="6881"
export TORRENT_PORT="51413"
export SOULSEEK_LISTEN_PORT="2234"
export SOULSEEK_OBFUSCATED_PORT="2235"

# Combine them for the Firewall (Comma-separated, NO spaces)
export WIREGUARD_FIREWALL_PORTS="${TORRENT_PORT},${SOULSEEK_LISTEN_PORT},${SOULSEEK_OBFUSCATED_PORT},${TRANSMISSION_PEER_PORT}"

# initialize paths & perms to PID
for p in ${RADARR_PATH} ${GLUETUN_PATH} ${DOWNLOADS_PATH} ${GLUETUN_CONFIG_PATH} ${RADARR_CONFIG_PATH} ${RADARR_MOVIES_PATH} ${RADARR_DOWNLOADS_PATH} ${TRANSMISSION_CONFIG_PATH};  do
    mkdir -p ${p} && sudo chown -R ${PUID}:${PGID} ${p}
    sudo chmod -R 775 ${p}
done

mkdir -p "${DOWNLOADS_PATH}/complete"
mkdir -p "${DOWNLOADS_PATH}/incomplete"

# Set permissions using the variables (Portable)
# We use $(id -gn) to get the group name dynamically instead of hardcoding 'staff'
# sudo chown -R "${PUID}:${PGID}" "$RADARR_PATH" "$GLUETUN_PATH"
# sudo chmod -R 775 "$RADARR_PATH" "$GLUETUN_PATH"

docker-compose up
