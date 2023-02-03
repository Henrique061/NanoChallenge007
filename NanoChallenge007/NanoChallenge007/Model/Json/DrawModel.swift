//
//  DrawModel.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation

public struct DrawModel : Deck {
    var success: Bool
    var deck_id: String
    var cards: [CardModel]
    var remaining: Int
}
