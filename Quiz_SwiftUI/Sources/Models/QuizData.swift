//
//  QuizData.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

/// クイズデータを格納する場所
struct QuizData {
    var question = "" // 問題文
    var correct = "" // 正解
    var choice: [String] = [] // 選択肢
}
