# Task Manager App - Clean Architecture & Unit Testing

This Task Manager app is built with an emphasis on **Clean Architecture**, **Mocking**, and **Unit Testing** using **Design Patterns** like **Singleton** and **Dependency Injection**. The project was developed in **10 hours** to demonstrate software development best practices.

---

## 📝 Table of Contents

1. [Introduction](#-introduction)
2. [Features](#-features)
3. [Installation](#-installation)
4. [Usage](#-usage)
5. [Design Decisions](#-design-decisions)
6. [Challenges Faced](#-challenges-faced)
7. [Extra Features](#-extra-features)
8. [Contributing](#-contributing)
9. [License](#-license)
10. [Acknowledgments](#-acknowledgments)

---

## 🚀 Introduction

This Task Manager app demonstrates the principles of **Clean Architecture**, enabling scalable, maintainable, and testable code. The app emphasizes unit testing using **mocking techniques** and ensures optimal software design using **design patterns** like Singleton and Dependency Injection.

---

## 🎯 Features

- **Clean Architecture:** Structuring the app into clear, separable layers for easy maintenance and extension.
- **Unit Testing:** Comprehensive unit testing for CRUD operations.
- **Design Patterns:** Use of Singleton and Dependency Injection for better code reusability and easier management of dependencies.
- **Task Management:** Basic CRUD functionalities for tasks.
- **Authentication:** Login system implemented following clean architecture principles.
- **Filteration:** You can filter the tasks based on the status.

---

## 🛠️ Installation

Follow these steps to get the app up and running locally:

1. Clone this repository:

    ```bash
    git clone https://github.com/Mokhtar628/task_manager
    ```

2. Navigate to the project folder:

    ```bash
    cd task_manager
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

5. test the app:

    ```bash
    flutter test
    ```

---

## 🧑‍💻 Usage

1. Launch the app on your simulator, emulator, or real device.
2. You can perform basic task management functions like creating, updating, and deleting tasks.
3. The login feature allows users to authenticate and access their tasks.
4. Filter the tasks based on thier status.

---

## 💡 Design Decisions

- **Clean Architecture**: I chose Clean Architecture to ensure separation of concerns. The app is divided into layers:

```
lib/
├── core/
├── features/
│   ├── auth/                      # Authentication feature
│   │   ├── data/                  # Data layer (models, data sources, repositories)
│   │   ├── domain/                # Domain layer (entities, use cases, repositories interface)
│   │   ├── presentation/          # Presentation layer (UI, providers, screens)
│   │   └── injection/             # Dependency Injection (DI) for auth
│   ├── tasks/                     # Task Management feature
│   │   ├── data/                  # Data layer (models, data sources, repositories)
│   │   ├── domain/                # Domain layer (entities, use cases,  repositories interface)
│   │   ├── presentation/          # Presentation layer (UI, providers, screens)
│   │   └── injection/             # Dependency Injection (DI) for tasks
├── app.dart                       # Root widget that ties everything together
└── main.dart                      # Entry point for the application
```


  This promotes testability and flexibility in modifying the application as needed.

- **Design Patterns**:
  - **Singleton**: Used for managing app-wide state and global dependencies in a centralized way.
  - **Dependency Injection**: Used to inject dependencies into classes rather than having them created inside the classes, ensuring easier testing and mocking.
  
- **Testing**: Mocking dependencies using the `mockito` library enabled isolated unit testing of business logic.

---

## 🚧 Challenges Faced

1. **Mocking**: Properly mocking the task repository while testing.
2. **Maintaining Code Quality**: Focusing on clean architecture and testing meant balancing development speed with adhering to software design principles.

---

## ✨ Extra Features

- **Design Pattern Implementation**: Incorporating Singleton and Dependency Injection throughout the app ensures easy maintainability and scalability.

---

## 👨‍💻 Contributing

Contributions are welcome! If you’d like to contribute to this project:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Make changes and commit them (`git commit -am 'Added new feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Submit a pull request.


---

## 🎉 Acknowledgments

- Flutter, for enabling the rapid development of clean architecture apps.
- `Mockito` for allowing effective unit testing with mocks.
- Clean Architecture pattern, for promoting testable and scalable applications.

---

