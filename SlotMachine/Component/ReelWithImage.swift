//
//  ReelWithImage.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 13/03/2024.
//

import SwiftUI

struct ReelWithImage: View {
    var imageName: String
    var body: some View {
        ZStack {
        ReelView()
        Image(imageName)
            .resizable()
            .modifier(ImageModifier())
    }
    }
}

 
