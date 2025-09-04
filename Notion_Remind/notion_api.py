import requests
from config import HEADERS

def query_database(database_id: str) -> list:
    url = f"https://api.notion.com/v1/databases/{database_id}/query"
    res = requests.post(url, headers=HEADERS, json={})
    res.raise_for_status()
    return res.json().get("results", [])

def get_page_property(props: dict, key: str, ptype: str) -> str:
    if key not in props:
        return ""
    value = props[key].get(ptype, [])
    if value and "text" in value[0]:
        return value[0]["text"]["content"]
    return ""
