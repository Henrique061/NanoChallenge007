//
//  GameManager.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 06/02/23.
//

import Foundation
import SwiftUI

public enum PlayerIds : Int {
    case p1 = 1
    case p2 = 2
    case none = 0
}

public class GameManager : ObservableObject {
    //MARK: VARS
    @Published var playerOne: PlayerHand
    @Published var playerTwo: PlayerHand
    @Published var deck: ShuffleModel
    
    var deckUtils: DeckUtils
    
    private var deckId: String
    private var startPlayer: PlayerIds
    private var currentPlayerTurn: PlayerIds
    private var roundNumber: Int
    private var roundFinished: Bool
    
    //MARK: GETTERS SETTERS
    var StartPlayer: PlayerIds {
        get { return self.startPlayer }
    }
    
    var ActualPlayerTurn: PlayerIds {
        get { return self.currentPlayerTurn }
    }
    
    var RoundNumber: Int {
        get { return self.roundNumber }
    }
    
    var DeckId: String {
        get { return self.deckId }
    }
    
    var RoundFinished: Bool {
        get { return self.roundFinished }
    }
    
    //MARK: INIT
    /**
     * Inicializa o game manager, já atribuindo os dois players e o player um começando a jogar na primeira rodada, além da rodada de número 1.
     */
    init(deckUtils: DeckUtils, completion: @escaping () -> ()) {
        self.playerOne = PlayerHand(id: PlayerIds.p1.rawValue)
        self.playerTwo = PlayerHand(id: PlayerIds.p2.rawValue)
        self.deckUtils = deckUtils
        self.startPlayer = .p1
        self.currentPlayerTurn = .p1
        self.roundNumber = 1
        self.roundFinished = false
        
        self.deck = ShuffleModel(success: false, deck_id: "", shuffled: false, remaining: 0)
        self.deckId = ""
    }
    
    public func shuffleDeck(completion: @escaping () -> ()) {
        deckUtils.getShuffle { shuffle in
            self.deck = shuffle
            self.deckId = shuffle.deck_id
            completion()
        }
    }
    
    //MARK: START ROUND
    /**
     * Começa o round, distribuindo 2 cartas para cada jogador, e já informando qual jogador começa a rodada
     */
    public func startRound(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            // inicializa qual jogador comeca na rodada
            if self.roundNumber % 2 != 0 { self.startPlayer = .p1 } // se for round numero impar, comeca com o player 1
            else { self.startPlayer = .p2 } // se for round numero par, comeca com player 2
            
            self.currentPlayerTurn = self.startPlayer
            
            // distribui as 2 primeiras cartas para ambos os jogadores
            self.deckUtils.drawCard(deckId: self.deckId, drawCount: 4) { draw in
                var p1Cards: [CardModel] = []
                var p2Cards: [CardModel] = []
                
                p1Cards.append(contentsOf: [draw.cards[0], draw.cards[1]])
                p2Cards.append(contentsOf: [draw.cards[2], draw.cards[3]])
                
                self.playerOne.hand.append(contentsOf: p1Cards)
                self.playerTwo.hand.append(contentsOf: p2Cards)
                completion()
            }
        }
    }
    
    //MARK: HIT
    public func hit(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            self.deckUtils.drawCard(deckId: self.deckId, drawCount: 1) { [self] draw in
                var player: PlayerHand
                
                if self.currentPlayerTurn == .p1 {
                    self.playerOne.hand.append(contentsOf: draw.cards)
                    player = self.playerOne
                }
                
                else {
                    self.playerTwo.hand.append(contentsOf: draw.cards)
                    player = self.playerTwo
                }
                
                if(PlayerUtils.getPlayerRoundScore(playerHand: player) >= 21){
                    self.stand()
                }
                
                
                completion()
            }
        }
    }
    
    //MARK: STAND
    public func stand() {
        if(startPlayer == currentPlayerTurn){
            if(PlayerIds.p1 == currentPlayerTurn){
                currentPlayerTurn = .p2
            } else {
                currentPlayerTurn = .p1
            }
        }
        else {self.roundFinished = true}
    }
    
    //MARK: FINISH ROUND
    /**
     * Finaliza o round, resetando as cartas dos players, atribuindo o placar do vencedor, reembaralhando deck e aumentando o numero do round
     */
    public func finishRound(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            var winner = PlayerIds.none
            let isDraw = self.checkDraw()
            
            // checa se empatou e da o vencedor
            if !isDraw { winner = self.checkWinner() }
            else { self.playerOne.finalScore += 1; self.playerTwo.finalScore += 1 }
            
            // atribui o vencedor se nao tiver dado empate
            if winner == .p1 { self.playerOne.finalScore += 1 }
            else if winner == .p2 { self.playerTwo.finalScore += 1 }
            
            // aumentando numero do round
            self.roundNumber += 1
            
            // resetando maos dos jogadores
            self.playerOne.hand = []
            self.playerTwo.hand = []
            
            self.roundFinished = false
            
            // reembaralhando cartas
            self.deckUtils.getReshuffle(deckId: self.deckId) { reshuffle in
                self.deck = reshuffle
                completion()
            }
        }
    }
    
    private func checkDraw() -> Bool {
        // dois estouram
        if playerOne.roundScore > 21 && playerTwo.roundScore > 21 { return true }
        // dois igualam
        else if playerOne.roundScore == playerTwo.roundScore { return true }
        // nao empata
        else { return false }
    }
    
    private func checkWinner() -> PlayerIds {
        // p1 ganha
        if (self.playerOne.roundScore > self.playerTwo.roundScore && self.playerOne.roundScore <= 21) || self.playerTwo.roundScore > 21 { return .p1 }
        else { return .p2 }
    }
}
