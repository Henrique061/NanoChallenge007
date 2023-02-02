//
//  CardModel.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 02/02/23.
//

import Foundation

public enum CardsValue : String, CaseIterable, Codable {
    case ace = "ACE"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "JACK"
    case queen = "QUEEN"
    case king = "KING"
}

public enum CardsSuits : String, Codable, CaseIterable {
    case clubs = "CLUBS" // paus
    case hearts = "HEARTS" // copas
    case spades = "SPADES" // espadas
    case diamonds = "DIAMONDS" // ouros
}

//public struct CardModel : Codable, Hashable, Identifiable{
//    
//}
