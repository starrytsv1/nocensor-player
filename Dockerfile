FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg python3 python3-pip ca-certificates && pip3 install --break-system-packages --no-cache-dir yt-dlp && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN npm install --omit=dev pg@8
COPY server.cjs index.html sw.js ./
ENV HOST=0.0.0.0 PORT=3874 PLAYER_DATA_DIR=/data PLAYER_MUSIC_DIR=/data/music YT_DLP_PATH=/usr/local/bin/yt-dlp FFMPEG_PATH=/usr/bin/ffmpeg REQUIRE_DATABASE=true
RUN mkdir -p /data/music && chown -R node:node /data
USER node
EXPOSE 3874
CMD ["node", "server.cjs"]

