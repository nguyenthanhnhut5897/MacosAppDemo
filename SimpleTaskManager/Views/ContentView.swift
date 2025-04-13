//
//  ContentView.swift
//  SimpleTaskManager
//
//  Created by Thanh Nhut on 10/4/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var isGridLayout = false
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("New task", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    guard !newTaskTitle.isEmpty else { return }
                    viewModel.addTask(title: newTaskTitle)
                    newTaskTitle = ""
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isGridLayout.toggle()
                    }
                }) {
                    Image(systemName: isGridLayout ? "list.bullet" : "square.grid.2x2")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding()
            
            if isGridLayout {
                // Grid layout
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                        ForEach(viewModel.tasks) { task in
                            TaskRowView(
                                task: task,
                                onToggle: { viewModel.toggleTask(task) },
                                onUpdate: { newTitle in viewModel.updateTaskTitle(task, newTitle: newTitle) },
                                onDelete: { viewModel.deleteTask(task) },
                                onCommitEdit: { newTitle in
                                    viewModel.updateTitle(task, newTitle: newTitle)
                                },
                                onDrop: { draggedTask in
                                    viewModel.moveTask(fromID: draggedTask.id, toID: task.id)
                                }
                            )
                            .environment(\.isGridLayout, isGridLayout)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                        }
                    }
                    .padding()
                }
            } else {
                // List layout
                List {
                    ForEach(Array(viewModel.tasks.enumerated()), id: \.element.id) { index, task in
                        TaskRowView(
                            task: task,
                            onToggle: { viewModel.toggleTask(task) },
                            onUpdate: { newTitle in viewModel.updateTaskTitle(task, newTitle: newTitle) },
                            onDelete: { viewModel.deleteTask(task) },
                            onCommitEdit: { newTitle in viewModel.updateTitle(task, newTitle: newTitle) }
                        )
                        .environment(\.isGridLayout, isGridLayout)
                    }
                    .onMove(perform: viewModel.moveTask)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
