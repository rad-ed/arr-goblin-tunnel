# whole-arr configs
export PUID=1000
export PGID=1000

# gluetun configs
export WIREGUARD_CONFIG_PATH="./goblin-tunnel-US-CA-188.conf"
export WIREGUARD_FIREWALL_PORTS="1:65535"
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
sudo chown -R $USER:$USER $RADAAR_PATH $GLUETUN_PATH

docker-compose up
