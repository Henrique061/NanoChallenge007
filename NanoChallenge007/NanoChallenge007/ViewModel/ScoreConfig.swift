//
//  ScoreLabel.swift
//  NanoChallenge007
//
//  Created by Barbara Argolo on 07/02/23.
//

import SwiftUI

struct ScoreLabel: View {
    
    var deckUtils: DeckUtils
    //completion é o que acontece quando termina a funcao async
    var gameManager: GameManager
    @State var scorePlayer1: Int
    @State var scorePlayer2: Int
    
    init() {
        self.deckUtils = DeckUtils()
        self.gameManager = GameManager(deckUtils: self.deckUtils, completion: {})
        self.scorePlayer1 = gameManager.playerOne.score
        self.scorePlayer2 = gameManager.playerTwo.score
    }
        
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("\(scorePlayer1) - \(scorePlayer2)")
                    .
            }
        }
    }
}

//struct ScoreLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreLabel()
//    }
//}
