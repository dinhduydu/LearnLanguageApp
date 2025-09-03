import requests
from config import DISCORD_WEBHOOK_URL, DISCORD_USER_ID

def send_discord_notification(message: str):
    """
    Gửi thông báo tới Discord channel qua webhook
    và mention user trực tiếp để chắc chắn có notify.
    """
    if not message:
        return

    content = f"<@{DISCORD_USER_ID}>\n{message}"
    res = requests.post(DISCORD_WEBHOOK_URL, json={"content": content})
    res.raise_for_status()
