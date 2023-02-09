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
    @State var p1CardsUrls: [String] = []
    @State var p2CardsUrls: [String] = []
    @State var canHit: Bool = false
    @State var notP1Turn: Bool = false
    @State var notP2Turn: Bool = true
    
    func startGame() {
        self.p1CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerOne)
        self.p2CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerTwo)
    }
    
    func buttonOpacity(notTurn: Bool) -> CGFloat {
        if notTurn { return 0.5 }
        else { return 1.0 }
    }
    
    func toggleTurn() {
        self.notP1Turn.toggle()
        self.notP2Turn.toggle()
    }
    
    func checkRoundFinish() {
        if self.gameManager.RoundFinished {
            self.notP2Turn = true
            self.notP1Turn = true
            self.gameManager.finishRound {
                self.gameManager.startRound(completion: self.startRound)
            }
        }
    }
    
    func startRound() {
        p1CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerOne)
        p2CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerTwo)
        self.gameManager.playerOne.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerOne)
        self.gameManager.playerTwo.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerTwo)
        self.canHit = true
        
        self.notP1Turn = self.gameManager.StartPlayer == .p2
        self.notP2Turn = self.gameManager.StartPlayer == .p1
    }
    
    var body: some View {
        ZStack {
            Color.init(red: 0.214, green: 0.458, blue: 0.174)
                .ignoresSafeArea()
            VStack {
                HStack {
                    // -- Botoes P2
                    Buttons(hitCompletion: {
                        print("butao")
                        if self.canHit {
                            print("butao sucesso")
                            self.canHit = false
                            self.gameManager.hit {
                                self.gameManager.playerTwo.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerTwo)
                                p2CardsUrls.append(PlayerUtils.getLastPlayerCardHand(playerHand: self.gameManager.playerTwo))
                                self.canHit = true
                                self.notP2Turn = self.gameManager.playerTwo.roundScore >= 21
                                
                                if notP2Turn {  self.notP1Turn = false }
                                self.checkRoundFinish()
                            }
                        }
                        
                    }, standCompletion: {
                        print("stand")
                        self.gameManager.stand()
                        self.toggleTurn()
                        self.checkRoundFinish()
                        
                    }).rotationEffect(Angle(degrees: 180))
                        .padding(.top, 50)
                        .disabled(self.notP2Turn)
                        .opacity(self.buttonOpacity(notTurn: self.notP2Turn))
                }
                
                .padding(.horizontal, 70)
                // -- cards P2
                HStack(alignment: .center, spacing: -50) {
                    ForEach(p2CardsUrls, id: \.self) { cardUrl in
                        ZStack {
                            AsyncImage(url: URL(string: cardUrl), content: { cardImage in
                                cardImage.image?.resizable()
                            })
                                .clipShape(Rectangle())
                                .frame(width: 100, height: 140, alignment: .bottom)
                        }
                    }
                }.padding(.top, 20)
                // -- Score P2
                RoundScoreConfig(roundScorePlayer1: $gameManager.playerOne.roundScore, roundScorePlayer2: $gameManager.playerTwo.roundScore, isPlayerOne: false).rotationEffect(Angle(degrees: 180))
                
                // -- final score
                FinalScoreLabel(finalScorePlayer1: $gameManager.playerOne.finalScore, finalScorePlayer2: $gameManager.playerTwo.finalScore)
                    .padding(.vertical, 10)
                
                // -- Score P1
                RoundScoreConfig(roundScorePlayer1: $gameManager.playerOne.roundScore, roundScorePlayer2: $gameManager.playerTwo.roundScore)
                
                // -- cards P1
                HStack(alignment: .center, spacing: -50) {
                    ForEach(p1CardsUrls, id: \.self) { cardUrl in
                        ZStack {
                            AsyncImage(url: URL(string: cardUrl), content: { cardImage in
                                cardImage.image?.resizable()
                            })
                                .clipShape(Rectangle())
                                .frame(width: 100, height: 140, alignment: .bottom)
                        }
                    }
                }.padding(.bottom, 20)
                HStack {
                    // -- Botoes P1
                    Buttons(hitCompletion: {
                        print("butao")
                        if self.canHit {
                            print("butao sucesso")
                            self.canHit = false
                            self.gameManager.hit {
                                self.gameManager.playerOne.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerOne)
                                p1CardsUrls.append(PlayerUtils.getLastPlayerCardHand(playerHand: self.gameManager.playerOne))
                                self.canHit = true
                                self.notP1Turn = self.gameManager.playerOne.roundScore >= 21
                                
                                if notP1Turn {  self.notP2Turn = false }
                                self.checkRoundFinish()
                            }
                        }
                        
                    }, standCompletion: {
                        self.gameManager.stand()
                        self.toggleTurn()
                        self.checkRoundFinish()
                        
                    }).padding(.bottom, 50)
                        .disabled(self.notP1Turn)
                        .opacity(self.buttonOpacity(notTurn: self.notP1Turn))
                }
                .padding(.horizontal, 70)
            }
        }
        .onAppear {
            self.gameManager.shuffleDeck {
                self.gameManager.startRound(completion: self.startRound)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//Image("3S")
//    .resizable()
//    .frame(width: 90, height: 105, alignment: .bottom)
