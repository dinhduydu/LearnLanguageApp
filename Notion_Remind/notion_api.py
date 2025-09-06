import requests
from config import HEADERS

def query_database(database_id: str) -> list:
    url = f"https://api.notion.com/v1/databases/{database_id}/query"
    res = requests.post(url, headers=HEADERS, json={})
    res.raise_for_status()
    return res.json().get("results", [])

def get_page_property(props: dict, name: str, prop_type: str) -> str:
    """
    Lấy giá trị property từ Notion page theo type.
    """
    if name not in props:
        return ""

    prop = props[name]
    if prop["type"] != prop_type:
        return ""

    if prop_type == "title":
        return "".join([t["plain_text"] for t in prop["title"]])
    elif prop_type == "rich_text":
        return "".join([t["plain_text"] for t in prop["rich_text"]])
    elif prop_type == "multi_select":
        return ", ".join([t["name"] for t in prop["multi_select"]])
    elif prop_type == "checkbox":
        return str(prop["checkbox"])
    elif prop_type == "date":
        return prop["date"]["start"] if prop["date"] else ""
    else:
        return ""
