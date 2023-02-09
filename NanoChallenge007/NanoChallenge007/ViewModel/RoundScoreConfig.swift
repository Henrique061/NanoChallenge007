//
//  RoundScoreConfig.swift
//  NanoChallenge007
//
//  Created by Barbara Argolo on 08/02/23.
//

import SwiftUI

struct RoundScoreConfig: View {
    
    var deckUtils: DeckUtils
    var isPlayerOne: Bool
    //completion é o que acontece quando termina a funcao async
    @Binding var roundScorePlayer1: Int
    @Binding var roundScorePlayer2: Int
    
    init(roundScorePlayer1: Binding<Int>, roundScorePlayer2: Binding<Int>, isPlayerOne: Bool = true) {
        self.deckUtils = DeckUtils()
        self._roundScorePlayer1 = roundScorePlayer1
        self._roundScorePlayer2 = roundScorePlayer2
        
        self.isPlayerOne = isPlayerOne
    }
    
    
    var body: some View {
        
        VStack {
            Text(isPlayerOne ? "\(roundScorePlayer1)" : "\(roundScorePlayer2)")
                .font(.system(size: 40).bold())
                .foregroundColor(.white)
            
        }
    }
}
