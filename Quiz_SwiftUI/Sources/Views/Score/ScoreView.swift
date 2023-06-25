//
//  ScoreView.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var quizManager: QuizManager
    @ObservedObject var googleMobileAdsManager: GoogleMobileAdsManager
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var shareManager = QuizResultShareManager()

    var body: some View {
        VStack(spacing: 42) {
            Text("\(quizManager.correctCount)問正解")
                .font(.custom(FontFamily.Caprasimo.regular, size: 42))
                .padding()
            Button {
                shareManager.shareApp("\(quizManager.correctCount)問正解しました, #クイズアプリ")
            } label: {
                Text("結果をシェアする")
                    .modifier(ButtonModifier(foregroundColor: .black, backgroundColor: .white))
            }
            .padding()
            Button {
                navigationManager.path.removeAll()
                quizManager.initializeQuizData()
            } label: {
                Text("トップに戻る")
                    .modifier(ButtonModifier(foregroundColor: .black, backgroundColor: .white))
            }
            .padding()
        }
        .onAppear {
            googleMobileAdsManager.setupBannerView()
            googleMobileAdsManager.addBannerViewToView(googleMobileAdsManager.bannerView)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Asset.Colors.bakcgroundColor.swiftUIColor
        )
    }

}

struct ScoreView_Previews: PreviewProvider {
    @State static var quizManager = QuizManager()
    @State static var googleMobileAdsManager = GoogleMobileAdsManager()
    static var previews: some View {
        ScoreView(quizManager: quizManager, googleMobileAdsManager: googleMobileAdsManager)
            .environmentObject(NavigationManager())
    }
}
