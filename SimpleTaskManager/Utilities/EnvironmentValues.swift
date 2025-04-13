//
//  EnvironmentValues.swift
//  SimpleTaskManager
//
//  Created by Thanh Nhut on 13/4/25.
//

import SwiftUI

private struct IsGridLayoutKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var isGridLayout: Bool {
        get { self[IsGridLayoutKey.self] }
        set { self[IsGridLayoutKey.self] = newValue }
    }
}
