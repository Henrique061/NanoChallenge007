//
//  HomeView.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation
import SwiftUI



struct HomeView: View {
    @StateObject private var gameManager = GameManager(deckUtils: DeckUtils(), completion: {})
    @State private var showBottomSheet: Bool = false
    @State var gameDeck: ShuffleModel? = nil
    @State var buttonPressed = ""
    
    var body: some View {
        
        
        ZStack {
            Color.init(red: 0.214, green: 0.458, blue: 0.174)
                .ignoresSafeArea()
            VStack {
                HStack {
                    
                    Buttons(completion: {
                        gameManager.playerTwo.roundScore += 1
                    }).rotationEffect(Angle(degrees: 180)).padding(.top, 50)
                }
                
                .padding(.horizontal, 60)
                //cards
                HStack(alignment: .center) {
                    ZStack(alignment: .center) {
                        Image("3S")
                            .resizable()
                            .frame(width: 90, height: 105, alignment: .bottom)
                    }
                }.padding(.top, 70)
                RoundScoreConfig(roundScorePlayer1: $gameManager.playerOne.roundScore, roundScorePlayer2: $gameManager.playerTwo.roundScore, isPlayerOne: false).rotationEffect(Angle(degrees: 180))
                //score
                FinalScoreLabel().padding(.vertical, 10)
                
                RoundScoreConfig(roundScorePlayer1: $gameManager.playerOne.roundScore, roundScorePlayer2: $gameManager.playerTwo.roundScore)
                
                //cards
                HStack(alignment: .center) {
                    ZStack(alignment: .center) {
                        Image("3S")
                            .resizable()
                            .frame(width: 90, height: 105, alignment: .bottom)
                    }
                }.padding(.bottom, 70)
                HStack {
                    Buttons(completion: {
                        gameManager.playerOne.roundScore += 1
                    }).padding(.bottom, 50)
                }
                .padding(.horizontal, 70)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

