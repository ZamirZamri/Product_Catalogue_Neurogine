# neurogine_product_catalog

Task Assignment for evaluation before interviews by Neurogine Sdn Bhd.
This project used Flutter for its stack environment. 

# Getting Started

Before begin, I draft how my file architecture will looks like, I chose GetX module-based pattern architecture

## Why I choose this architecture?
i. Clear Separation of Concerns: It strictly divides the Data layer (api, constants) from my Presentation layer (modules), which directly satisfies Requirement #6.

ii. Feature-First Organization: Grouping by feature (listing_product, detail_product) instead of by type shows I know how to build scalable apps. If this app grew to 50 screens, this structure would survive perfectly.

iii. Common Reusability: Having a common folder for common_widgets.dart (where we will put your Loading, Error, and Empty states) shows great code hygiene.

## Here is the draft:
lib/
├── app/
│   └── data/        
│   │  └── api/
│   │  │    ├── api_methods.dart
│   │  │    ├── api_constant.dart 
│   │  │    └── api_models
│   │  │         ├── api_list_model.dart
│   │  │         ├── api_detail_model.dart
│   │  │         └── api_search_model.dart               
│   │  │
│   │  └── constants/
│   │      ├── gif_constants.dart
│   │      ├── icons_constants.dart
│   │      ├── image_constants.dart
│   │      └── string_constants.dart
│   │  
│   ├── modules/
│   │  ├── listing_product
│   │  │    ├── bindings
│   │  │    │   └── listing_product_binding.dart
│   │  │    ├── controllers
│   │  │    │   └── listing_product_controller.dart
│   │  │    │   └── search_product_controller.dart
│   │  │    └── views
│   │  │         └── listing_product_view.dart
│   │  │    
│   │  └── detail_product
│   │       ├── bindings
│   │       │   └── detail_product_binding.dart
│   │       ├── controllers
│   │       │   └── detail_product_controller.dart
│   │       └── views
│   │           └── detail_product_view.dart
│   │       
│   │  
│   ├── routes/
│   │       ├── app_pages.dart
│   │       └── approutes.dart
│   │
│   └── common/
│       ├── alert_dialog_view.dart
│       ├── common_methods.dart
│       ├── common_widgets.dart
│       ├── http_methods.dart
│       ├── theme_data.dart
│       └── progress_bar.dart
│
└── main.dart

