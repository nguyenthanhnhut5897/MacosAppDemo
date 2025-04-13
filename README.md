# MacosAppDemo

✨ A simple macOS To-Do application built with SwiftUI, featuring both **list** and **grid** layouts, task editing, drag-and-drop reordering, and local persistence using `UserDefaults`.

## 🚀 Features

- ✅ Add, edit, and delete tasks
- 🔄 Toggle task completion
- 📝 Edit task titles directly
- 🗂 Switch between **list** and **grid** views
- 📦 Drag & drop to reorder tasks in grid mode
- 💾 Tasks are saved persistently using `UserDefaults`

## 🎥 Demo

https://github.com/user-attachments/assets/21c6dbc1-aa5b-4383-9a35-a0ea2e57daea

## 🛠 Technologies Used

- Swift
- SwiftUI
- Combine
- UserDefaults for lightweight data storage

## 📁 Project Structure

- `TaskItem`: Model for each task
- `TaskViewModel`: Manages the task list and handles logic
- `TaskRowView`: Displays individual task rows with editing & drag support
- `ContentView`: Main view that toggles between list and grid layouts

## 🧑‍💻 Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/nguyenthanhnhut5897/MacosAppDemo.git
    ```

2. Open `MacosAppDemo.xcodeproj` in Xcode.

3. Build and run on macOS using the latest Xcode version.

## 🧪 Roadmap / Ideas
- [ ] Add status of each task item
- [ ] Add Dark Mode support
- [ ] iCloud sync
- [ ] Task due dates or categories
- [ ] SwiftData or Core Data support

## 📄 License

This project is open source and available under the MIT License.

---

> Built with ❤️ by [Nguyễn Thành Nhựt](https://github.com/nguyenthanhnhut5897)
