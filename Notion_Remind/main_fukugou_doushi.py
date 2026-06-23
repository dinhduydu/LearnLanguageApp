from config import MASTER_DATABASE_ID
from extractor import extract_words
from discord_notifier import send_discord_notification

FUKUGOU_DOUSHI_CATEGORY = "複合動詞"


def main():
    words_text = extract_words(MASTER_DATABASE_ID, category=FUKUGOU_DOUSHI_CATEGORY)

    if words_text:
        message = "📚 Hôm nay học:\n" + words_text
        send_discord_notification(message)


if __name__ == "__main__":
    main()
