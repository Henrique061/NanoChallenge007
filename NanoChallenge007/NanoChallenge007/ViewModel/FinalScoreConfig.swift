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
    @State var finalScorePlayer1: Int
    @State var finalScorePlayer2: Int
    
    init() {
        self.deckUtils = DeckUtils()
        self.gameManager = GameManager(deckUtils: self.deckUtils, completion: {})
        self.finalScorePlayer1 = gameManager.playerOne.finalScore
        self.finalScorePlayer2 = gameManager.playerTwo.finalScore
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("1 - \(finalScorePlayer2)").padding(.horizontal, 20)
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white)
                
                
            }.frame(alignment: .bottom)
                .rotationEffect(Angle(degrees: 90), anchor: UnitPoint(x: 0.5, y: 0.5))
            
            
        }
    }
}

struct FinalScoreLabel_Previews: PreviewProvider {
    static var previews: some View {
        FinalScoreLabel()
    }
}
