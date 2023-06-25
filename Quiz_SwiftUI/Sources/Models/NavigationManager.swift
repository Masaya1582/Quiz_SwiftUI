//
//  NavigationManager.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

/// 表示させるViewを管理する
enum ShowView: Hashable {
    case levelView
    case quizView
    case scoreView
}

final class NavigationManager: ObservableObject {
    @Published var path: [ShowView] = []
}
