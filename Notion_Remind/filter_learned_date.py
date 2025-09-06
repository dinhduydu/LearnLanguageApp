def filter_learned_date(props: dict) -> bool:
    """
    Trả về True nếu page nên bị bỏ qua 
    (đã Learned = True hoặc có Date).
    Trả về False nếu giữ lại.
    """
    learned = props.get("Learned")
    date = props.get("Date")

    # Nếu có cột Learned và checkbox = True → bỏ
    if learned and learned.get("checkbox") is True:
        return True

    # Nếu có cột Date và có giá trị → bỏ
    if date and date.get("date"):
        return True

    return False
