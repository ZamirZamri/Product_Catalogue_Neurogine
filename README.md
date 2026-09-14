# neurogine_product_catalog

Task Assignment for evaluation before interviews by Neurogine Sdn Bhd.
This project used Flutter for its stack environment. 

# Getting Started

Before begin, I draft how my file architecture will looks like, I chose GetX module-based pattern architecture

## Why I choose this architecture?
i. Clear Separation of Concerns: It strictly divides the Data layer (api, constants) from my Presentation layer (modules), which directly satisfies Requirement #6.

ii. Feature-First Organization: Grouping by feature (listing_product, detail_product) instead of by type shows I know how to build scalable apps. If this app grew to 50 screens, this structure would survive perfectly.

iii. Common Reusability: Having a common folder for common_widgets.dart (where we will put your Loading, Error, and Empty states) shows great code hygiene.

## 🌟 Key Features

*   **Paginated Grid Listing:** Efficiently fetches and displays products in a 2-column grid. Automatically loads the next batch of products (20 at a time) when the user scrolls near the bottom.
*   **Debounced Server-Side Search:** Allows users to query the entire database. Utilizes a 500ms debounce to prevent API spam and optimize network performance.
*   **Comprehensive State Handling:** Gracefully handles and displays custom UI for Loading, Error (with retry mechanism), Empty, and Success states.
*   **Modern Glassmorphism UI:** Features a custom, native iOS-style frosted glass aesthetic with transparent backgrounds, subtle borders, and smooth shadows.
*   **Product Detail Screen:** Includes a swipeable image gallery, dynamic pricing/ratings, and a reactive "Favorite" toggle with custom sliding glass alerts.
*   **Image Caching:** Utilizes `cached_network_image` to save bandwidth and improve performance, complete with custom aesthetic loading placeholders.

## Here is the draft:
<img width="422" height="807" alt="image" src="https://github.com/user-attachments/assets/a6dada67-391d-49ed-886d-6d0b0760e868" />

## Here is the UI progress during development
i) <img width="477" height="998" alt="Screenshot 2026-09-11 152358" src="https://github.com/user-attachments/assets/104665ac-d1d7-4b8e-9dc5-242809eee1bc" />

ii) <img width="452" height="947" alt="Screenshot 2026-09-11 153749" src="https://github.com/user-attachments/assets/5f0fdb23-b24a-4050-940e-98a703d49637" />

iii) <img width="455" height="978" alt="Screenshot 2026-09-11 161642" src="https://github.com/user-attachments/assets/3583ef20-5702-4355-b244-3e4b2ba96e67" />

iv) <img width="462" height="970" alt="Screenshot 2026-09-11 172100" src="https://github.com/user-attachments/assets/45c064ab-232a-4a4b-8e58-f263c2bdab94" />

## 🔮 Future Improvements
*   **Persistent Local Storage:** Utilizing `sqflite` or `Hive` to save the user's "Favorite" products locally, ensuring their curated list persists even after the app is completely closed.
*   **Advanced Filtering & Sorting:** Expanding the search capabilities to include category filtering, price range sliders, and sorting options (e.g., Price: Low to High).
*   **Custom Cloud Backend:** Transitioning from the DummyJSON API to a custom microservice architecture managed via AWS, including secure cloud storage for rendering high-resolution product assets.
*   **Sliver App Bar:** Adding a collapsing header in the detail screen for a more immersive, modern scrolling experience.
