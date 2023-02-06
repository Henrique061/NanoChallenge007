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
    private var playerOne: PlayerHand
    private var playerTwo: PlayerHand
    private var startPlayer: PlayerIds
    private var roundNumber: Int
    
    //MARK: GETTERS SETTERS
    var PlayerOne: PlayerHand {
        get { return self.playerOne }
    }
    
    var PlayerTwo: PlayerHand {
        get { return self.playerTwo }
    }
    
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
    public init() {
        self.playerOne = PlayerHand(id: PlayerIds.p1.rawValue)
        self.playerTwo = PlayerHand(id: PlayerIds.p2.rawValue)
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
