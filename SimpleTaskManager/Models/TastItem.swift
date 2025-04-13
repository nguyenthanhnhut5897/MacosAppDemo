//
//  TastItem.swift
//  SimpleTaskManager
//
//  Created by Thanh Nhut on 10/4/25.
//

import Foundation

struct TaskItem: Identifiable, Codable {
    let id: UUID?
    var title: String?
    var isDone: Bool
    var isEditing: Bool = false
    
    init(id: UUID? = UUID(), title: String?, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}
