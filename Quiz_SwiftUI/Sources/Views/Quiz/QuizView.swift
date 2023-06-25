//
//  QuizView.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var quizManager: QuizManager
    @ObservedObject var googleMobileAdsManager: GoogleMobileAdsManager
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            Asset.Colors.bakcgroundColor.swiftUIColor
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("第\(quizManager.quizCount + 1)問")
                    .font(.largeTitle)
                    .padding(.vertical, 5)
                TextEditor(text: $quizManager.currentQuizData.question)
                    .disabled(true) // テキスト編集を不可能にする
                    .foregroundColor(.black)
                    .scrollContentBackground(.hidden) // TextEditorの背景を隠す (initを使うやり方もある？)
                    .background(.clear)
                    .frame(height: UIScreen.main.bounds.height / 13)
                    .lineSpacing(5)
                    .padding()
                ForEach(quizManager.currentQuizData.choice, id: \.self) { choice in
                    Button {
                        quizManager.judgeAnswer(choice)
                    } label: {
                        Text(choice)
                            .modifier(ButtonModifier(foregroundColor: .black, backgroundColor: .white))
                    }
                    .disabled(quizManager.isDuringJudge)
                }
                Spacer()
            }
            if quizManager.isDuringJudge {
                Image(systemName: quizManager.imageData.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    .foregroundColor(quizManager.imageData.color)
            }
        }
        .onAppear {
            quizManager.setQuiz()
            googleMobileAdsManager.setupBannerView()
            googleMobileAdsManager.addBannerViewToView(googleMobileAdsManager.bannerView)
        }
        .onChange(of: quizManager.isEndQuiz) { isEndQuiz in
            if isEndQuiz {
                navigationManager.path.append(.scoreView)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
