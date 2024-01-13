# Appcent NewsApp Application

## Project Description
This project is a mobile application that allows users to follow news updates, search for news, view details, and save favorite articles.

## Project Requirements
Use Swift Package Manager to add the following packages:
- Firebase SDK: 'https://github.com/firebase/firebase-ios-sdk.git'
- Alamofire: 'https://github.com/Alamofire/Alamofire.git'
- Kingfisher: 'https://github.com/onevcat/Kingfisher.git'

If you come across the 'You have made too many requests recently. Developer accounts are limited to 100 requests over a 24-hour period (50 requests available every 12 hours).' warning, it indicates that you have reached the API rate limit. As a developer, you are restricted to 100 requests within a 24-hour timeframe, with 50 requests allowed every 12 hours. To resolve this issue, please follow the steps outlined below.
- Get your API key from [newsapi.org](https://newsapi.org/).
- Open the 'APIURLs.swift' file in the 'AppcentNewsApp/Helpers' folder, and replace the return value of the 'apiKey' static function with the new API key you get.

## Project Overview

### Technologies
- SwiftUI
- UIKit just for WebView
- Firebase Authentication
- Firestore

### Methodologies
- OOP

### Design Patterns
- Dependency Injection

### Libraries
- Alamofire
- Kingfisher

### Architectures
- Model-View-ViewModel (MVVM)

## Usage
1. Launch the application.
2. Use the search bar on the main screen to search for news.
3. Select an article from the search results.
4. View the details of the selected article.
5. On the detail page, click the "New Source" button to visit the source website.
6. On the detail page, you can share the article link and add it to your favorites.

## Screenshots

### Auth
![GMP_U2F2ZUdIMDE= 2](https://github.com/oguzzyildirim/AppcentNewsApp/assets/56165405/b5a09e49-0301-4e65-b820-e625b6f639b0)
![GMP_U2F2ZUdIMDE=](https://github.com/oguzzyildirim/AppcentNewsApp/assets/56165405/66a9de19-97b8-4c1a-92de-8ddeb71f0b0f)

### Overview
![Video](https://github.com/oguzzyildirim/AppcentNewsApp/assets/56165405/a377b2f4-f5e0-4dde-b7d1-2b8f5ee6fa5d)

## License Information
This project is licensed under the [MIT License](LICENSE).

## Contact Information
For any questions or feedback, feel free to reach out: [oguzyildirimyo@icloud.com](mailto:oguzyildirimyo@icloud.com).
