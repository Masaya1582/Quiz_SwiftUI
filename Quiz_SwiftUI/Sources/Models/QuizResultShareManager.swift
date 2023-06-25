//
//  QuizResultShareManager.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

/// シェア機能
final class QuizResultShareManager {
    func shareApp(_ shareText: String) {
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        let windowscene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootViewController = windowscene?.windows.first?.rootViewController
        rootViewController?.present(activityViewController, animated: true)
    }
}
