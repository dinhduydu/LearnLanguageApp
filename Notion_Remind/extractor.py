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
    words: list[tuple[str, str]] = []  # (page_id, display_text)
    subdb_sections: list[str] = []

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
                subdb_sections.append(f"▶ Sub-database:\n{sub_words}")
        else:
            entry = f"- {kanji_title} / {hira} / {vn}"
            if hanviet:
                entry += f" / {hanviet}"  # thêm Hán Việt nếu có
            words.append((page["id"], entry))

    if recursive:
        # Filter learned first
        learned_page_ids: set[str] = set()
        for page in results:
            props = page["properties"]
            learned_prop = props.get("Learned")
            if learned_prop and learned_prop.get("checkbox") is True:
                learned_page_ids.add(page["id"])

        total_words = len(words)
        learned_count = sum(1 for page_id, _ in words if page_id in learned_page_ids)
        remaining_unlearned = total_words - learned_count

        # When remaining words < 5, reset all learned -> not learned
        if total_words > 0 and remaining_unlearned < 5:
            for page_id, _ in words:
                try:
                    update_learned_and_date(page_id, False, date=None)
                except Exception as e:
                    print("Reset failed:", e)
            learned_page_ids.clear()

        candidates = [(page_id, text) for page_id, text in words if page_id not in learned_page_ids]
        if not candidates:
            return "\n".join(subdb_sections) if subdb_sections else ""

        # Randomize remaining words and pick up to 5
        random.shuffle(candidates)
        selected = candidates[: min(5, len(candidates))]

        # Mark selected as learned + set last studied
        for page_id, _ in selected:
            try:
                update_learned_and_date(page_id, True, today)
            except Exception as e:
                print("Update failed:", e)

        selected_text = "\n".join(text for _, text in selected)
        if subdb_sections:
            return selected_text + "\n" + "\n".join(subdb_sections)
        return selected_text
    else:
        return "\n".join(text for _, text in words)
