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
}

public class GameManager : ObservableObject {
    //MARK: VARS
    @Published var playerOne: PlayerHand
    @Published var playerTwo: PlayerHand
    
    var deckUtils: DeckUtils
    
    private var startPlayer: PlayerIds
    private var roundNumber: Int
    
    //MARK: GETTERS SETTERS
    var StartPlayer: PlayerIds {
        get { return self.startPlayer }
    }
    
    var RoundNumber: Int {
        get { return self.roundNumber }
    }
    
    //MARK: INIT
    /**
     * Inicializa o game manager, já atribuindo os dois players e o player um começando a jogar na primeira rodada, além da rodada de número 1.
     */
    init(deckUtils: DeckUtils) {
        self.playerOne = PlayerHand(id: PlayerIds.p1.rawValue)
        self.playerTwo = PlayerHand(id: PlayerIds.p2.rawValue)
        self.deckUtils = deckUtils
        self.startPlayer = .p1
        self.roundNumber = 1
    }
    
    //MARK: METHODS
    /**
     * Começa o round, distribuindo 2 cartas para cada jogador, e já informando qual jogador começa a rodada
     */
    public func startRound() {
        
    }
    
    public func hit() {
        
    }
    
    public func stand() {
        
    }
}
