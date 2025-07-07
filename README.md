Widget Update: 
![image](https://github.com/user-attachments/assets/5104c1b8-e200-4bbe-8cc0-f3feb0e6c3f2)
Create folder:
![image](https://github.com/user-attachments/assets/f2e92034-9770-4785-bfae-37e6c1d1932e)
Create multi folders, files:
![image](https://github.com/user-attachments/assets/6704dbb7-1695-49fb-bac2-b3c3437e6df4)
FOLDER STRUCTURE:
lib/
├── main.dart
└── features/
    ├── folder/
    │   ├── domain/
    │   │   └── folder.dart
    │   └── presentation/
    │       ├── pages/
    │       │   ├── folder_home_page.dart        # HOME page
    │       │   └── folder_detail_page.dart
    │       └── widgets/
    │           ├── folder_tile.dart
    │           ├── create_folder_dialog.dart
    │           └── create_file_dialog.dart
    ├── notion/
    │   ├── domain/
    │   │   └── notion_note.dart                 # Model dữ liệu từ Notion
    │   ├── services/
    │   │   └── notion_service.dart              # Gọi API Notion
    │   └── widgets/
    │       └── sync_button.dart                 # Nút sync và tiến độ
    └── setting/
        └── presentation/
            └── pages/
                └── setting_page.dart            # Cài đặt nhập token & DB ID
