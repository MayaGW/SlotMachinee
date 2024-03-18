//
//  ReelWithImage.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 13/03/2024.
//

import SwiftUI

struct ReelWithImage: View {
    // @State private var animatingSymbol: Bool = false
    @Binding var animatingSymbol: Bool
    var imageName: String
    var randomDouble: Double
    
    var body: some View {
        ZStack {
            ReelView()
            Image(imageName)
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .onAppear {
                
                        withAnimation(.easeOut(duration: randomDouble)) {
                            self.animatingSymbol = true
                       
                    }
                    
                }
 
        }
    }}

 
