//
//  LevelView.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

struct LevelView: View {
    @ObservedObject var quizManager: QuizManager
    @ObservedObject var googleMobileAdsManager: GoogleMobileAdsManager
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        VStack(spacing: 42) {
            Text("難易度を選択")
                .font(.custom(FontFamily.Caprasimo.regular, size: 42))
            ForEach(1..<4) { index in
                Button {
                    quizManager.selectLevel = index
                    navigationManager.path.append(.quizView)
                } label: {
                    Text("レベル\(index)")
                        .modifier(ButtonModifier(foregroundColor: .white, backgroundColor: index == 1 ? Asset.Colors.levelOneColor.swiftUIColor : index == 2 ? Asset.Colors.levelTwoColor.swiftUIColor : Asset.Colors.levelThreeColor.swiftUIColor))
                }
            }
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

struct LevelView_Previews: PreviewProvider {
    @State static var quizManager = QuizManager()
    @State static var googleMobileAdsManager = GoogleMobileAdsManager()
    static var previews: some View {
        LevelView(quizManager: quizManager, googleMobileAdsManager: googleMobileAdsManager)
            .environmentObject(NavigationManager())
    }
}
