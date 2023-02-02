//
//  Deck.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 02/02/23.
//

import Foundation

protocol Deck: Codable, Hashable, Identifiable {
    var success: Bool { get }
    var deck_id: String { get }
}
