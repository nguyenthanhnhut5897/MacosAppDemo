//
//  TaskRowView.swift
//  SimpleTaskManager
//
//  Created by Thanh Nhut on 10/4/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct TaskRowView: View {
    @State private var editedTitle: String
    @FocusState private var isFocused: Bool
    @Environment(\.isGridLayout) var isGridLayout
    
    let task: TaskItem
    var onToggle: () -> Void
    var onUpdate: (String) -> Void
    var onDelete: () -> Void
    var onCommitEdit: (String) -> Void
    var onDrop: ((TaskItem) -> Void)? = nil

    init(task: TaskItem,
         onToggle: @escaping () -> Void,
         onUpdate: @escaping (String) -> Void,
         onDelete: @escaping () -> Void,
         onCommitEdit: @escaping (String) -> Void,
         onDrop: ((TaskItem) -> Void)? = nil
    ) {
        self.task = task
        self._editedTitle = State(initialValue: task.title ?? "")
        self.onToggle = onToggle
        self.onUpdate = onUpdate
        self.onDelete = onDelete
        self.onCommitEdit = onCommitEdit
        self.onDrop = onDrop
    }

    var body: some View {
        HStack {
            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                .onTapGesture { onToggle() }

            TextField("", text: $editedTitle, onCommit: {
                onCommitEdit(editedTitle)
                isFocused = false
            })
            .textFieldStyle(PlainTextFieldStyle())
            .focused($isFocused)

            Spacer()

            Button(action: onDelete) {
                Image(systemName: "trash")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .if(isGridLayout) { view in
            view
                .onDrag {
                    NSItemProvider(object: NSString(string: task.id?.uuidString ?? ""))
                }
                .onDrop(of: [UTType.text], delegate: TaskDropDelegate(onDrop: onDrop))
        }
    }
}

struct TaskDropDelegate: DropDelegate {
    let onDrop: ((TaskItem) -> Void)?
    
    func performDrop(info: DropInfo) -> Bool {
        guard let provider = info.itemProviders(for: [UTType.text]).first else { return false }
        provider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (data, _) in
            DispatchQueue.main.async {
                if let str = data as? Data,
                   let idStr = String(data: str, encoding: .utf8),
                   let uuid = UUID(uuidString: idStr) {
                    let draggedTask = TaskItem(id: uuid, title: "") // chỉ cần id
                    onDrop?(draggedTask)
                }
            }
        }
        return true
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
