//
//  ReelView.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 13/03/2024.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image(.gfxReel)
            .resizable()
            .modifier(ImageModifier())
          
    }
}

#Preview(traits: .fixedLayout(width: 220, height: 220)) {
    ReelView()
}
