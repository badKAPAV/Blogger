# Blogger

This Flutter application requests data from an API and shows them to the user. The user can also opt to refresh the API request to get new blogs to read. The blog tiles are interactible and the user can like blogs. Made with clean, minimal and responsive UI in mind, its easy to use and present and read.

https://github.com/user-attachments/assets/10d4f5a1-a5a3-4705-9f1c-ccc411b45d2c

## Features
- Calls data from API, flexible to use huge amount and variety of data to be integrated
- Blogs can be marked as favorite
- Bloc is used for advanced state management for larger projects
- Creative UI/UX for maximum engagement of user, clean and minimalistic design

## Project Structure

```
lib/
│
├── assets/                  # Contains assets for usage
│   ├── load_img.png         
│
├── bloc/                    # Contains bloc state management
│   ├── blog_bloc.dart       # Bloc logic code
│
├── pages/                   # Contains the UI pages/screens
│   ├── blog_page.dart       # Page that shows the list of Blogs
│   ├── detail_screen.dart   # Additional page that shows an expanded detail of the blog
│
├── services/                # Contains api and other services
│   ├── api_service.dart     # Makes Api calls and handles the Blog model
│
└── main.dart                # Entry point of the application
```

## Contact
For any queries regarding the project, feel free to contact me [here](avigyandas123@gmail.com)
