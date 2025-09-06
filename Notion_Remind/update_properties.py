import requests
from config import HEADERS

def update_learned_and_date(page_id: str, learned: bool, date: str = None):
    """
    Update cột 'Learned' (checkbox) và 'Date' (date) của 1 page trong Notion.
    :param page_id: ID của page
    :param learned: True/False để đánh dấu đã học
    :param date: string dạng YYYY-MM-DD
    """
    url = f"https://api.notion.com/v1/pages/{page_id}"

    properties = {
        "Learned": {"checkbox": learned}
    }

    if date:
        properties["Last Studied"] = {
            "date": {"start": date}
        }

    payload = {"properties": properties}
    res = requests.patch(url, headers=HEADERS, json=payload)

    if res.status_code != 200:
        raise Exception(f"Update failed: {res.status_code} - {res.text}")

    return res.json()
