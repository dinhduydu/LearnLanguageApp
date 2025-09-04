from notion_api import query_database, get_page_property
from config import HEADERS
import random

def extract_words(database_id: str, recursive: bool = True) -> str:
    """
    Lấy các từ từ database chính. Nếu gặp sub-database trong cột Kanji thì
    sẽ đệ quy in sạch toàn bộ nội dung sub-db (không check Learned/Date).
    """
    results = query_database(database_id)
    words = []

    for page in results:
        props = page["properties"]

        kanji_title = get_page_property(props, "漢字第", "title")
        hira = get_page_property(props, "ひらがな", "rich_text")
        vn = get_page_property(props, "ベトナム語", "rich_text")

        # Nếu Kanji là sub-database (link)
        if recursive and kanji_title.startswith("https://www.notion.so/"):
            # Lấy ID từ link
            sub_id = kanji_title.split("/")[-1].split("?")[0]
            sub_words = extract_words(sub_id, recursive=False)
            if sub_words:
                words.append(f"▶ Sub-database:\n{sub_words}")
        else:
            entry = f"- {kanji_title} / {hira} / {vn}"
            words.append(entry)

    # Chọn ngẫu nhiên tối đa 5 từ từ database chính
    if recursive:
        return "\n".join(random.sample(words, min(5, len(words))))
    else:
        return "\n".join(words)
