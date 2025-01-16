# 📱 Task Manager App

A modern, efficient, and user-friendly Task Manager application designed for productivity. It allows users to manage their daily tasks and optimize their time.

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

This Task Manager app helps you to efficiently organize your tasks, set priorities, and track progress. It features user authentication, task management, and pagination.

---

## 🎯 Features

- **User Authentication:** Users can sign in and manage tasks.
- **Task Management:** CRUD operations for tasks.
- **Responsive UI:** Great performance across devices.
- **Animations:** Smooth page transitions and custom animation effects.

---

## 🛠️ Installation

To run the app locally, follow these steps:

1. Clone this repository:

    ```bash
    git clone https://github.com/YOUR_USERNAME/your-repo-name.git
    ```

2. Navigate to the project folder:

    ```bash
    cd your-repo-name
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

---

## 🧑‍💻 Usage

1. Open the app on your simulator/emulator or real device.
2. Sign in using valid credentials.
3. Start adding tasks with deadlines and priorities.
4. Use the task manager interface to edit or remove tasks.

---

## 💡 Design Decisions

- **State Management:** I chose `Provider` for clean state management across the app. It helps maintain a simple, understandable structure for managing app state.
- **UI/UX:** The user interface follows a minimalistic design philosophy, using rich animations for smooth navigation and an immersive user experience.
- **Animations:** Used the `AnimatedBuilder` and `FadeTransition` to animate form fields and buttons for a smooth, polished feel.
- **Responsiveness:** Made sure the app is responsive on both small and large screens using `MediaQuery` and flexible widgets.

---

## 🚧 Challenges Faced

1. **User Authentication:** Handling asynchronous login states and ensuring smooth error handling was challenging. To address this, I implemented loading indicators while the login process is running.
2. **Animations Performance:** Optimizing custom animations so they don’t affect performance, especially on lower-end devices.
3. **Task CRUD Operations:** Setting up efficient error handling and form validation.

---

## ✨ Extra Features

- **Forgot Password functionality:** Users can recover their accounts if they forget their password.
- **Pagination:** Tasks are paginated for improved performance and user experience.
- **Animated Transitions:** Smoother UI transitions to make the app more engaging.

---

## 👨‍💻 Contributing

We welcome contributions! If you'd like to contribute to this project:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.


---

## 🎉 Acknowledgments

- Flutter - for providing an excellent framework for building apps.
- Provider - for managing the app state.
- Icon Library by [Icons8](https://icons8.com/icons).
- [Unsplash](https://unsplash.com) for the free-to-use images in the project.
