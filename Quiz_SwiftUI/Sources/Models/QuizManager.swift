//
//  QuizManager.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

final class QuizManager: ObservableObject {
    @Published var quizCount = 0 // 問題番号
    @Published var correctCount = 0 // 正解数
    @Published var selectLevel = 0 // レベル選択
    @Published var isDuringJudge = false // 画像 & ボタンの管理
    @Published var isEndQuiz = false // 問題が全て終了したかどうかのフラグ
    @Published var quizDataArray: [QuizData] = []
    @Published var currentQuizData = QuizData(question: "", correct: "", choice: [])
    @Published var imageData = (name: "", color: Color.white) // 画像の種類、色を管理

    // QuizViewが表示される時に呼ばれる関数
    func setQuiz() {
        var quizCSVArray = loadCSV("Quiz\(selectLevel)")
        quizCSVArray.shuffle() // 問題をシャッフルする
        quizCSVArray.forEach {
            let quizArray = $0.components(separatedBy: ",")
            var quizData = QuizData()
            quizData.question = quizArray[0]
            quizData.correct = quizArray[1]
            quizData.choice = [quizArray[2], quizArray[3], quizArray[4], quizArray[5]]
            quizDataArray.append(quizData)
        }
        currentQuizData = quizDataArray[quizCount]
    }

    // 正誤判定を行う
    func judgeAnswer(_ chosenAnswer: String) {
        if chosenAnswer == currentQuizData.correct { // 正解の場合
            correctCount += 1
            imageData = ("circle", .red)
        } else { // 不正解の場合
            imageData = ("multiply", .blue)
        }
        isDuringJudge = true // 画像を表示 & ボタンを押せなくする
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            self.isDuringJudge = false
            self.setNextQuiz()
        }
    }

    // 次の問題をセットする or ScoreViewに遷移する
    func setNextQuiz() {
        if quizCount >= quizDataArray.count - 1 {
            isEndQuiz = true
            return
        }
        quizCount += 1
        // CSV問題数内であればクイズ出題をし続ける
        currentQuizData = quizDataArray[quizCount]
    }

    // CSVファイルの読み込み
    func loadCSV(_ fileName: String) -> [String] {
        guard let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            fatalError("ファイルが見つかりません")
        }
        var dataArray: [String] = []
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: .utf8)
            dataArray = csvData.components(separatedBy: "\n")
            dataArray.removeLast()
        } catch {
            print("エラー: \(error)")
        }
        return dataArray
    }

    // 問題データの初期化
    func initializeQuizData() {
        quizCount = 0
        correctCount = 0
        quizDataArray.removeAll()
        isEndQuiz = false
    }

}
