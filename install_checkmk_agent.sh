#!/bin/bash

# URL của file .deb từ máy chủ Checkmk
AGENT_URL="https://noc-da.ominext.info/monitor/check_mk/agents/check-mk-agent_2.2.0b2-1_all.deb"

echo "[*] Tải về Checkmk agent..."
wget -q "$AGENT_URL" -O check-mk-agent.deb || { echo "❌ Tải thất bại"; exit 1; }

echo "[*] Cài đặt agent..."
sudo dpkg -i check-mk-agent.deb || { echo "❌ Lỗi khi cài đặt"; exit 1; }

echo "[*] Kích hoạt và khởi động socket..."
sudo systemctl enable --now check-mk-agent.socket

echo "[*] Kiểm tra trạng thái socket..."
sudo systemctl status check-mk-agent.socket

echo "✅ Cài đặt hoàn tất. Agent đang lắng nghe trên port 6556."
