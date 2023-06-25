//
//  GoogleMobileAdsManager.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI
import GoogleMobileAds

/// バナー広告設定
final class GoogleMobileAdsManager: ObservableObject {
    @Published var bannerView: GADBannerView!

    func setupBannerView() {
        let bannerSize = CGSize(width: 320, height: 50)
        bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(bannerSize))
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        bannerView.rootViewController = window.rootViewController
        bannerView.load(GADRequest())
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        guard let rootViewController = window.rootViewController else { return }
        rootViewController.view.addSubview(bannerView)
        rootViewController.view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: rootViewController.view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: rootViewController.view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }

}
