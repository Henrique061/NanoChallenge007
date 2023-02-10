//
//  ScoreLabel.swift
//  NanoChallenge007
//
//  Created by Barbara Argolo on 07/02/23.
//

import SwiftUI

struct FinalScoreLabel: View {
    
    var deckUtils: DeckUtils
    //completion é o que acontece quando termina a funcao async
    var gameManager: GameManager
    @Binding var finalScorePlayer1: Int
    @Binding var finalScorePlayer2: Int
    @Binding var turnMessage: String
    @Binding var turnMessageRotation: CGFloat
    
    init(finalScorePlayer1: Binding<Int>, finalScorePlayer2: Binding<Int>, turnMessage: Binding<String>, turnMessageRotation: Binding<CGFloat>) {
        self.deckUtils = DeckUtils()
        self.gameManager = GameManager(deckUtils: self.deckUtils, completion: {})
        self._finalScorePlayer1 = finalScorePlayer1
        self._finalScorePlayer2 = finalScorePlayer2
        self._turnMessage = turnMessage
        self._turnMessageRotation = turnMessageRotation
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(turnMessage)
                .font(.system(size: 25).bold())
                .rotationEffect(Angle(degrees: turnMessageRotation))
                .foregroundColor(Color.init(red: 1, green: 0.72, blue: 0))
            
            VStack {
                Text("\(finalScorePlayer2) - \(finalScorePlayer1)").padding(.horizontal, 20)
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white)
                
            }.frame(alignment: .bottom)
                .rotationEffect(Angle(degrees: 90), anchor: UnitPoint(x: 0.5, y: 0.5))
        }
    }
}
