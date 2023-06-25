//
//  ButtonModifier.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    let foregroundColor: Color
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 28, alignment: .center)
            .padding()
            .border(Color.black, width: 1.5)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .padding()
    }
}
