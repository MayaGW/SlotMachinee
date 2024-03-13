//
//  ContentView.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 12/03/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    
    
    //MARK: - BODY
    var body: some View {
       
        ZStack {
            //BACKGROUND
            LinearGradient(gradient: Gradient(colors: [.colorPink, .colorPurple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //INTERFACE
            VStack(alignment:.center,spacing: 5) {
                 
                //HEADER
               LogoView()
                Spacer()
                //SCORE
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                    }//HSTACK
                    .modifier(ScoreContainerModifier()) 
                    Spacer()
                    HStack{
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }//HSTACK
                    .modifier(ScoreContainerModifier())
                }//HSTACK
              
                //SLOTMACHINE
                VStack(alignment: .center , spacing: 0){
                    //Reel 1
                    ReelWithImage(imageName: "gfx-bell")
                    HStack(alignment: .center, spacing: 0){
                        //Reel2
                        ReelWithImage(imageName: "gfx-seven")
                        Spacer()
                        //Reel3
                        ReelWithImage(imageName: "gfx-cherry")
                    }.frame(maxWidth: 500)
                    //Spin Button
                    
                    Button(action: {
                        print("Spin the button")
                    }, label: {
                        Image(.gfxSpin)
                            .resizable()
                            .renderingMode(.original)
                            .modifier(ImageModifier())
                             
                    })
                    
                }//SLOTMACHINE
                .layoutPriority(2)
                
                
                
                
                
                //FOOTER

                Spacer()
                
                HStack{
                    //BET20
                    HStack (alignment:.center, spacing: 10){
                        Button(action: {
                            print("BET 20")
                        }
                               , label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .modifier(BetNumberModifier())
                                
                        })
                        .modifier(BetCapsulModifier())
                     
                        
                        
                Image(.gfxCasinoChips)
                    .resizable()
                    .opacity(0)
                    .modifier(CasinoShipsModifier())
                    }//INNER HSTACK   
                    //BET 10
                    HStack (alignment:.center, spacing: 10){
                        Image(.gfxCasinoChips)
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoShipsModifier())
                        
                        
                        Button(action: {
                            print("BET 10")
                        }
                               , label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                                .modifier(BetNumberModifier())
                                
                        })
                        .modifier(BetCapsulModifier())
                     
                        
                        
                 
                    }//INNER HSTACK
                    Spacer()
                    //
                }//HSTACK
            }.overlay(
            //RESET
                Button(action: {
                    print("Reset the Game")
                })  {
                    Image(systemName: "arrow.2.circlepath.circle")
                } //BUTTON 1
                    .modifier(ButtonModifier())
                    ,alignment: .topLeading
            ).overlay(
            //RESET
                Button(action: {
                    print("Info View")
                })  {
                    Image(systemName: "info.circle")
                } //BUTTON 1
                    .modifier(ButtonModifier())
                ,alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            
            
            //POPUP
        }//ZSTACK
        
         
    }
}
//MARK: - PREVIEW
#Preview {
    ContentView()
}
