//
//  HomeView.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @ObservedObject var quizManager = QuizManager()
    @ObservedObject var googleMobileAdsManager = GoogleMobileAdsManager()
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                Text("SwiftUIクイズ")
                    .font(.custom(FontFamily.Rubik.boldItalic, size: 42))
                    .padding()
                Button {
                    navigationManager.path.append(.levelView)
                } label: {
                    Text("スタート")
                        .modifier(ButtonModifier(foregroundColor: .white, backgroundColor: Asset.Colors.startColor.swiftUIColor))
                }
            }
            .onAppear {
                googleMobileAdsManager.setupBannerView()
                googleMobileAdsManager.addBannerViewToView(googleMobileAdsManager.bannerView)
            }
            .navigationDestination(for: ShowView.self) { showView in
                switch showView {
                case .levelView:
                    LevelView(quizManager: quizManager, googleMobileAdsManager: googleMobileAdsManager)
                case .quizView:
                    QuizView(quizManager: quizManager, googleMobileAdsManager: googleMobileAdsManager)
                case .scoreView:
                    ScoreView(quizManager: quizManager, googleMobileAdsManager: googleMobileAdsManager)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Asset.Colors.bakcgroundColor.swiftUIColor
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(NavigationManager())
    }
}
