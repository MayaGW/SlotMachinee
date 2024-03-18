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
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betamount: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showModel : Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animationModel: Bool = false
    
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
        UserDefaults.standard.set(highScore, forKey: "HighScore")
    }
    func playerLoses(){
        coins -= betamount
    }
    
    func activateBet10(){
        betamount = 10
        isActiveBet20 = false
        isActiveBet10 = true
    }
    func activateBet20(){
        betamount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    //GAme overe
    func isGameOver(){
        if coins <= 0 {
            //Show modal windows
            showModel = true
        }
    }
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "Highscore")
        highScore = 0
        coins = 100
        activateBet10()
    }
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
                    ReelWithImage(animatingSymbol: $animatingSymbol, imageName: symbols[reels[0]], randomDouble: Double.random(in: 0.5...0.7))
                    
                    
                    HStack(alignment: .center, spacing: 0){
                        //Reel2
                        ReelWithImage(animatingSymbol: $animatingSymbol, imageName: symbols[reels[1]], randomDouble:Double.random(in: 0.7...0.9))
                          
                        Spacer()
                        //Reel3
                        ReelWithImage(animatingSymbol:$animatingSymbol, imageName: symbols[reels[2]], randomDouble: Double.random(in: 0.9...1.1))
                        
                    }.frame(maxWidth: 500)
                    //Spin Button
                    
                    Button(action: {
                       //1. set the default state no animation
                        
                        withAnimation{
                            self.animatingSymbol = false
                        }
                        print("helll")
                        spinReels()
                        //Trigger animation after changing the symbol
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                               withAnimation {
                                   self.animatingSymbol = true
                               }
                     
                        }
                        print("helll2")
                        checkWinings()
                        isGameOver()
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
                           activateBet20()
                        }
                               , label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor( isActiveBet20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                                
                        })
                        .modifier(BetCapsulModifier())
                     
                        
                        
                Image(.gfxCasinoChips)
                    .resizable()
                    .offset(x: isActiveBet20 ? 0 : 20)
                    .opacity(isActiveBet20  ? 1 : 0)
                    
                    .modifier(CasinoShipsModifier())
                    }//INNER HSTACK   
                    //BET 10
                    HStack (alignment:.center, spacing: 10){
                        Image(.gfxCasinoChips)
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1  : 0)
                            .modifier(CasinoShipsModifier())
                        
                        
                        Button(action: {
                            activateBet10()
                        }
                               , label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? .yellow : .white)
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
                    resetGame()
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
            .blur(radius: $showModel.wrappedValue ? 5 : 0, opaque: false)
            
            
            //POPUP
            
            
            if $showModel.wrappedValue{
                ZStack{
                    Color(.colorTransparentBlack).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    //Model
                    VStack(spacing: 0){
                        //TTLE
                        Text("Game Over!".uppercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                            .background(.colorPink)
                            .foregroundColor(.white)
                        Spacer()
                        //MESSAGE
                        VStack(alignment:.center, spacing: 16){
                            Image(.gfxSevenReel)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad Luck! you lost all the coins. \nLet's play again")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                showModel = false
                                animationModel = false
                                coins = 100
                                
                            }, label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(.colorPink)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule().stroke(lineWidth: 1.75)
                                            .foregroundColor(.colorPink)
                                    )
                            })
                        }
                        Spacer()
                    }//Vstack
                    .frame(minWidth: 200, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .colorTransparentBlack, radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 8)
                    .opacity( animationModel  ? 1 : 0)
                    .offset(y: animationModel  ? 0 : -100 )
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1, blendDuration: 1))
                    .onAppear(perform: {
                        self.animationModel = true
                    })
                }
            }
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
