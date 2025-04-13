//
//  TaskViewModel.swift
//  SimpleTaskManager
//
//  Created by Thanh Nhut on 10/4/25.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadTasks()
    }
    
    func addTask(title: String) {
        let newTask = TaskItem(title: title)
        tasks.append(newTask)
        saveTasks()
    }
    
    func toggleTask(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
            saveTasks()
        }
    }
    
    func updateTitle(_ task: TaskItem, newTitle: String) {
        updateTask(task) {
            $0.title = newTitle
            $0.isEditing = false
        }
        saveTasks()
    }
    
    private func updateTask(_ task: TaskItem, mutate: (inout TaskItem) -> Void) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        var updated = tasks[index]
        mutate(&updated)
        tasks[index] = updated
        
        saveTasks()
    }
    
    func moveTask(fromID: UUID?, toID: UUID?) {
        guard let fromIndex = tasks.firstIndex(where: { $0.id == fromID }),
              let toIndex = tasks.firstIndex(where: { $0.id == toID }) else { return }
        
        let moved = tasks.remove(at: fromIndex)
        tasks.insert(moved, at: toIndex)
        
        saveTasks()
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func deleteTask(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            saveTasks()
        }
    }
    
    func updateTaskTitle(_ task: TaskItem, newTitle: String) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].title = newTitle
        saveTasks()
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
        saveTasks()
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "Tasks"),
           let saved = try? JSONDecoder().decode([TaskItem].self, from: data) {
            tasks = saved
        }
    }
    
    private func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: "Tasks")
        }
    }
}
