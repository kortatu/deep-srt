#!/bin/bash

./srt/build/srt-live-transmit udp://localhost:1234 "$MEDIUM://$RECEIVER_ADDRESS:$RECEIVER_PORT?latency=$LATENCY" -v -stats-report-frequency $REPORT_FREQUENCY -statsout -pf csv &
exec ffmpeg -f lavfi -re -i smptebars=duration=300:size=1280x720:rate=30 -f lavfi -re -i sine=frequency=1000:duration=60:sample_rate=44100 -pix_fmt yuv420p -c:v libx264 -b:v 1000k -g 30 -keyint_min 120 -profile:v baseline -preset fast -f mpegts "udp://127.0.0.1:1234?pkt_size=1316" > /dev/null

