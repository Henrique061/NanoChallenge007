//
//  PlayerModel.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 06/02/23.
//

import Foundation

/**
 * Struct para armazenar o id do player e quais as cartas que ele tem em maos
 */
public struct PlayerHand {
    var id: Int
    var roundScore: Int
    var finalScore: Int
    var hand: [CardModel]
    
    /**
     * Inicializa um jogador passando todos os seus parametros (OPCIONAL).
     */
    public init(id: Int, roundScore: Int, finalScore: Int, hand: [CardModel]) {
        self.id = id
        self.roundScore = roundScore
        self.finalScore = finalScore
        self.hand = hand
    }
    
    /**
     * Inicializa um jogador passando apenas seu id, desta forma, o placar começa zerado e sua mão começa vazia.
     */
    public init(id: Int) {
        self.id = id
        self.roundScore = 0
        self.finalScore = 0
        self.hand = []
    }
}
