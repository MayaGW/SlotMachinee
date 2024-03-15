//
//  ContentView.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 12/03/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    @State private var reels: Array = [0,1,2]
    @State private var showingInfoView: Bool = false
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betamount: Int = 10
    //MARK: - Functioms
    //Spin the reels
    func spinReels(){
//     reels[0] = Int.random(in: 0...symbols.count - 1)
//     reels[1] = Int.random(in: 0...symbols.count - 1)
//     reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        
    }
    //Check the winings
    func checkWinings(){
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            // player wins
            playerWins()
            //new heighSocre
            if coins > highScore{
                newHighScore()
            }
        }
        else{
          playerLoses()
           
        }
    }
    func playerWins(){
        coins += betamount * 10
    }
    func newHighScore(){
        highScore = coins
    }
    func playerLoses(){
        coins -= betamount
    }
    //GAme overe
    
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
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                    }//HSTACK
                    .modifier(ScoreContainerModifier()) 
                    Spacer()
                    HStack{
                        Text("\(highScore)")
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
                    ReelWithImage(imageName: symbols[reels[0]])
                    HStack(alignment: .center, spacing: 0){
                        //Reel2
                        ReelWithImage(imageName: symbols[reels[1]])
                        Spacer()
                        //Reel3
                        ReelWithImage(imageName: symbols[reels[2]])
                    }.frame(maxWidth: 500)
                    //Spin Button
                    
                    Button(action: {
                       //Spin the reels
                        spinReels()
                        checkWinings()
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
                    showingInfoView = true
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
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
         
    }
}
//MARK: - PREVIEW
#Preview {
    ContentView()
}
