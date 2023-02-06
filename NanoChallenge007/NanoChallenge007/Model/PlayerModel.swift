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
    var score: Int
    var hand: [CardModel]
    
    /**
     * Inicializa um jogador passando todos os seus parametros.
     */
    public init(id: Int, score: Int, hand: [CardModel]) {
        self.id = id
        self.score = score
        self.hand = hand
    }
    
    /**
     * Inicializa um jogador passando apenas seu id, desta forma, o placar começa zerado e sua mão começa vazia.
     */
    public init(id: Int) {
        self.id = id
        self.score = 0
        self.hand = []
    }
}
