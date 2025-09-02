import os
import random
import requests

NOTION_API_KEY = os.getenv("NOTION_API_KEY")
DATABASE_ID = os.getenv("NOTION_DATABASE_ID")
NOTION_URL = "https://api.notion.com/v1/databases/{}/query".format(DATABASE_ID)
HEADERS = {
    "Authorization": f"Bearer {NOTION_API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

def get_words():
    res = requests.post(NOTION_URL, headers=HEADERS)
    data = res.json()
    return data.get("results", [])

def update_today_flag(page_id):
    url = f"https://api.notion.com/v1/pages/{page_id}"
    payload = {
        "properties": {
            "Today": {"checkbox": True}
        }
    }
    requests.patch(url, headers=HEADERS, json=payload)

def main():
    words = get_words()
    unchecked = [w for w in words if not w["properties"]["Today"]["checkbox"]]
    
    if not unchecked:
        print("No more words to study.")
        return

    today_words = random.sample(unchecked, min(5, len(unchecked)))
    for w in today_words:
        page_id = w["id"]
        update_today_flag(page_id)
        print(f"Marked word {w['properties']['Word']['title'][0]['text']['content']} for today.")

if __name__ == "__main__":
    main()
