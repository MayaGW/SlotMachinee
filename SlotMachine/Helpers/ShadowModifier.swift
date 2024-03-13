//
//  ShadowModifier.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 13/03/2024.
//

import SwiftUI

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content.shadow(color: .colorTransparentBlack, radius: 0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6)
    }

}
struct ButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.title)
            .accentColor(.white)
    }
}
struct ScoreNumberModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color: .colorTransparentBlack, radius: 0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 3)
            .layoutPriority(1)
    }
}
struct ScoreContainerModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.horizontal,16)
            .padding(.vertical, 4)
            .frame(minWidth: 126)
            .background(
            Capsule()
                .foregroundColor(.colorTransparentBlack)
            )
    }
}

