from notion_api import query_database, get_page_property
from update_properties import update_learned_and_date
import random
import datetime

def extract_words(database_id: str, recursive: bool = True) -> str:
    """
    Lấy các từ từ database chính.
    - Nếu gặp sub-database trong cột Kanji thì đệ quy in toàn bộ nội dung sub-db (không check Learned/Date).
    - Nếu có cột Hán Việt (multi_select) thì in kèm.
    - Update Learned + Last Studied cho các từ được chọn.
    """
    results = query_database(database_id)
    words = []

    today = datetime.date.today().isoformat()

    for page in results:
        props = page["properties"]

        kanji_title = get_page_property(props, "漢字第", "title")
        hira = get_page_property(props, "ひらがな", "rich_text")
        vn = get_page_property(props, "ベトナム語", "rich_text")
        hanviet = get_page_property(props, "Hán Việt", "multi_select")  # lấy multi_select

        # Nếu Kanji là sub-database (link Notion)
        if recursive and kanji_title.startswith("https://www.notion.so/"):
            sub_id = kanji_title.split("/")[-1].split("?")[0]
            sub_words = extract_words(sub_id, recursive=False)
            if sub_words:
                words.append(f"▶ Sub-database:\n{sub_words}")
        else:
            entry = f"- {kanji_title} / {hira} / {vn}"
            if hanviet:
                entry += f" / {hanviet}"  # thêm Hán Việt nếu có
            words.append(entry)

    if recursive:
        # Chọn ngẫu nhiên tối đa 5 từ
        selected = random.sample(words, min(5, len(words)))

        # Update Learned + Last Studied cho các từ được chọn
        for page in results[:len(selected)]:
            try:
                update_learned_and_date(page["id"], True, today)
            except Exception as e:
                print("Update failed:", e)

        return "\n".join(selected)
    else:
        return "\n".join(words)
