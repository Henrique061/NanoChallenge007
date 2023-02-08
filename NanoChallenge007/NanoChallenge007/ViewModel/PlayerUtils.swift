//
//  PlayerUtils.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 07/02/23.
//

import Foundation

class PlayerUtils {
    //MARK: GETTERS
    /**
     * Recebe um model de um player e retorna um vetor com os links das imagens das cartas que tem em sua respectiva mao
     */
    public static func getPlayerCardsImagesUrl(playerHand: PlayerHand) -> [String] {
        var cardsUrl: [String] = []
        
        if playerHand.hand.isEmpty { return [] }
        
        for card in playerHand.hand {
            cardsUrl.append(card.images.svg)
        }
        
        return cardsUrl
    }
    
    /**
     * Recebe um model de um player e retorna o link da imagem da ultima carta recebida na mao desse jogador
     */
    public static func getLastPlayerCardHand(playerHand: PlayerHand) -> String {
        if playerHand.hand.isEmpty { return "" }
        
        return playerHand.hand.last?.images.svg ?? ""
    }
    
    //MARK: SETTERS
    /**
     * Pega todas as cartas atuais na mao do jogador e atualiza seu placar do round
     */
    public static func getPlayerRoundScore(playerHand: PlayerHand) -> Int {
        if playerHand.hand.isEmpty { return 0 }
        
        var totalValue: Int = 0
        
        for card in playerHand.hand {
            totalValue += self.getCardValue(playerHand: playerHand, cardValue: CardsValue(rawValue: card.value) ?? .ace)
        }
        
        return totalValue
    }
    
    //MARK: AUX METHODS
    public static func getCardValue(playerHand: PlayerHand, cardValue: CardsValue) -> Int {
        switch cardValue {
            case .ace: return self.checkAceValue(playerHand: playerHand)
            case .two: return 2
            case .three: return 3
            case .four: return 4
            case .five: return 5
            case .six: return 6
            case .seven: return 7
            case .eight: return 8
            case .nine: return 9
            default: return 10
        }
    }
    
    public static func checkAceValue(playerHand: PlayerHand) -> Int {
        if playerHand.hand.isEmpty { return 0 }
        
        var aceCount: Int = 0
        var othersValue: Int = 0
        
        for card in playerHand.hand {
            if card.value == CardsValue.ace.rawValue { aceCount += 1; continue }
            if aceCount > 1 { return 1 }
            
            othersValue += self.getCardValue(playerHand: playerHand, cardValue: CardsValue(rawValue: card.value) ?? .two)
        }
        
        if othersValue > 10 { return 1 }
        
        return 11
    }
}
