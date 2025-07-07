lib/
├── main.dart
├── app.dart                      # MaterialApp, route, theme
├── core/
│   ├── constants/                # app_colors.dart, app_text.dart
│   └── theme/                    # light_theme.dart, dark_theme.dart
├── shared/
│   ├── services/                 # NotionService ở đây
│   ├── widgets/                  # Reusable UI: Button, Loader
│   └── extensions/               # string_extension.dart
└── features/
    └── vocabulary/
        ├── data/
        │   ├── models/           # VocabularyModel
        │   ├── sources/          # NotionVocabularySource
        │   └── repositories/     # VocabularyRepositoryImpl
        ├── domain/
        │   ├── entities/         # VocabularyEntity
        │   └── usecases/         # FetchVocabularyUsecase
        └── presentation/
            ├── pages/            # VocabularyPage
            └── widgets/          # WordCard
