//
//  HomeView.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation
import SwiftUI



struct HomeView: View {
    //MARK: VARS
    @StateObject private var gameManager = GameManager(deckUtils: DeckUtils(), completion: {})
    @State private var showBottomSheet: Bool = false
    @State var gameDeck: ShuffleModel? = nil
    @State var buttonPressed = ""
    @State var p1CardsUrls: [String] = []
    @State var p2CardsUrls: [String] = []
    @State var canHit: Bool = false
    @State var notP1Turn: Bool = false
    @State var notP2Turn: Bool = true
    @State var turnMessage: String = "↓ YOUR TURN ↓"
    @State var turnMessageRotation: CGFloat = 0
    @State var canStart: Bool = true
    
    let turnString = "↓ YOUR TURN ↓"
    let winnerString = "🎉 ↓ YOU WIN ↓ 🎉"
    let drawString = "🟡 ↓ DRAW ↑ 🟡"
    
    //MARK: START GAME
    func startGame() {
        self.p1CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerOne)
        self.p2CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerTwo)
    }
    
    //MARK: BUTTON OPACITY
    func buttonOpacity(notTurn: Bool) -> CGFloat {
        if notTurn { return 0.5 }
        else { return 0.9 }
    }
    
    //MARK: TOGGLE TURN
    func toggleTurn() {
        self.notP1Turn.toggle()
        self.notP2Turn.toggle()
    }
    
    //MARK: CHECK ROUND FINISH
    func checkRoundFinish() {
        if self.gameManager.RoundFinished {
            self.notP2Turn = true
            self.notP1Turn = true
            self.gameManager.finishRound {
                self.checkTurnMessage()
            }
        }
    }
    
    //MARK: START ROUND
    func startRound() {
        //if !canStart { return }
        
        var player: PlayerHand
        
        p1CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerOne)
        p2CardsUrls = PlayerUtils.getPlayerCardsImagesUrl(playerHand: self.gameManager.playerTwo)
        self.gameManager.playerOne.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerOne)
        self.gameManager.playerTwo.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerTwo)
        self.canHit = true
        
        self.notP1Turn = self.gameManager.StartPlayer == .p2
        self.notP2Turn = self.gameManager.StartPlayer == .p1
        
        if self.gameManager.StartPlayer == .p1 { player = self.gameManager.playerOne }
        else { player = self.gameManager.playerTwo }
        
        self.checkTurnMessage()
        
        if PlayerUtils.getPlayerRoundScore(playerHand: player) == 21 { self.standPhase() }
    }
    
    //MARK: STAND PHASE
    func standPhase() {
        self.gameManager.stand()
        self.toggleTurn()
        self.checkTurnMessage()
        self.checkRoundFinish()
    }
    
    //MARK: HIT PHASE
    func hitPhase(_ playerId: PlayerIds) {
        if self.canHit {
            self.canHit = false
            self.gameManager.hit {
                if playerId == .p1 {
                    self.gameManager.playerOne.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerOne)
                    p1CardsUrls.append(PlayerUtils.getLastPlayerCardHand(playerHand: self.gameManager.playerOne))
                    
                    self.notP1Turn = self.gameManager.playerOne.roundScore >= 21
                    if notP1Turn {  self.notP2Turn = false }
                }
                
                else {
                    self.gameManager.playerTwo.roundScore = PlayerUtils.getPlayerRoundScore(playerHand: self.gameManager.playerTwo)
                    p2CardsUrls.append(PlayerUtils.getLastPlayerCardHand(playerHand: self.gameManager.playerTwo))
                    
                    self.notP2Turn = self.gameManager.playerTwo.roundScore >= 21
                    if notP2Turn {  self.notP1Turn = false }
                }
                
                self.canHit = true
                self.checkRoundFinish()
            }
        }
    }
    
    //MARK: TURN MESSAGE
    func checkTurnMessage() {
        if !self.gameManager.RoundFinished {
            self.turnMessage = self.turnString
            if self.gameManager.ActualPlayerTurn == .p1 { self.turnMessageRotation = 0 }
            else { self.turnMessageRotation = 180 }
        }
        
        else {
            self.canStart = true
            
            if self.gameManager.PlayerWinner != .none {
                self.turnMessage = self.winnerString
                
                if self.gameManager.PlayerWinner == .p1 { self.turnMessageRotation = 0 }
                else { self.turnMessageRotation = 180 }
            }
            
            else {
                self.turnMessageRotation = 0
                self.turnMessage = self.drawString
            }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0, qos: .background) {
                if self.canStart {
                    self.gameManager.startRound(completion: self.startRound)
                    self.canStart = false
                }
                
            }
        }
    }
    
    //MARK: BODY
    var body: some View {
        ZStack {
            Color.init(red: 0, green: 0.306, blue: 0.251)
                .ignoresSafeArea()
            VStack {
                HStack {
                    //MARK: BUTTONS P2
                    Buttons(hitCompletion: {
                        self.hitPhase(.p2)
                    }, standCompletion: {
                        self.standPhase()
                        
                    }).rotationEffect(Angle(degrees: 180))
                        .padding(.top, 50)
                        .disabled(self.notP2Turn)
                        .opacity(self.buttonOpacity(notTurn: self.notP2Turn))
                }
                
                .padding(.horizontal, 70)
                //MARK: CARDS P2
                HStack(alignment: .center, spacing: -50) {
                    ForEach(p2CardsUrls, id: \.self) { cardUrl in
                        ZStack {
                            AsyncImage(url: URL(string: cardUrl)) { cardImage in
                                cardImage.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                .clipShape(Rectangle())
                                .frame(width: 100, height: 140, alignment: .bottom)

//                            AsyncImage(url: URL(string: cardUrl), content: { cardImage in
//                                cardImage.image?.resizable()
//                            })
//                                .clipShape(Rectangle())
//                                .frame(width: 100, height: 140, alignment: .bottom)
                        }
                    }
                }.padding(.top, 20)
                //MARK: SCORE P2
                RoundScoreConfig(roundScorePlayer1: $gameManager.playerOne.roundScore, roundScorePlayer2: $gameManager.playerTwo.roundScore, isPlayerOne: false).rotationEffect(Angle(degrees: 180))
                
                //MARK: FINAL SCORE
                FinalScoreLabel(finalScorePlayer1: $gameManager.playerOne.finalScore, finalScorePlayer2: $gameManager.playerTwo.finalScore, turnMessage: $turnMessage, turnMessageRotation: $turnMessageRotation)
                    .padding(.vertical, 10)
                
                //MARK: SCORE P1
                RoundScoreConfig(roundScorePlayer1: $gameManager.playerOne.roundScore, roundScorePlayer2: $gameManager.playerTwo.roundScore)
                
                //MARK: CARDS P1
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
                    //MARK: BUTTONS P1
                    Buttons(hitCompletion: {
                        self.hitPhase(.p1)
                    }, standCompletion: {
                        self.standPhase()
                        
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

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

//Image("3S")
//    .resizable()
//    .frame(width: 90, height: 105, alignment: .bottom)
