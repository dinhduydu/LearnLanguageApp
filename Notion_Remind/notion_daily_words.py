import os
import random
import requests
from datetime import datetime

# Lấy API Key + Database ID từ GitHub Secrets
NOTION_API_KEY = os.getenv("NOTION_API_KEY")
DATABASE_ID = os.getenv("NOTION_DATABASE_ID")

NOTION_URL = f"https://api.notion.com/v1/databases/{DATABASE_ID}/query"
HEADERS = {
    "Authorization": f"Bearer {NOTION_API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

# Lấy danh sách từ chưa học (Learned == False)
def get_words():
    payload = {
        "filter": {
            "property": "Learned",
            "checkbox": {"equals": False}
        }
    }
    res = requests.post(NOTION_URL, headers=HEADERS, json=payload)
    data = res.json()
    print("DEBUG:", data)

    if "results" not in data:
        print("Error from Notion API:", data)
        return []

    return data["results"]

# Update Last Studied = hôm nay
def update_last_studied(page_id):
    url = f"https://api.notion.com/v1/pages/{page_id}"
    today = datetime.utcnow().isoformat()
    payload = {
        "properties": {
            "Last Studied": {"date": {"start": today}}
        }
    }
    requests.patch(url, headers=HEADERS, json=payload)

# (Tuỳ chọn) Mark là đã học
def mark_learned(page_id):
    url = f"https://api.notion.com/v1/pages/{page_id}"
    payload = {
        "properties": {"Learned": {"checkbox": True}}
    }
    requests.patch(url, headers=HEADERS, json=payload)

def main():
    words = get_words()
    print("DB_ID:", DATABASE_ID)
    print("API_KEY exists:", bool(NOTION_API_KEY))
    if not words:
        print("No more words to study.")
        return

    # Chọn ngẫu nhiên tối đa 5 từ
    today_words = random.sample(words, min(5, len(words)))
    for w in today_words:
        page_id = w["id"]
        word_text = w["properties"]["漢字第"]["title"][0]["text"]["content"]

        update_last_studied(page_id)  # update ngày hôm nay
        print(f"Studying word: {word_text}")

if __name__ == "__main__":
    main()
