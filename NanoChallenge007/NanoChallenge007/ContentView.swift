//
//  ContentView.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var deckUtils = DeckUtils()
    
    @State var gameDeck: ShuffleModel? = nil
    @State var playerHand: DrawModel? = nil
    
    @State var deckId: String = ""
    
    var body: some View {
        VStack {
            HomeView()
        }
        .padding()
        Text("Ola")
            .padding()
            .onAppear() {
                self.deckUtils.getShuffle(completion: { (shuffle) in
                    self.gameDeck = shuffle
                    self.deckId = shuffle.deck_id
                    print(self.gameDeck!)
                    
                    self.deckUtils.drawCard(deckId: self.deckId, drawCount: 1) { draw in
                        self.playerHand = draw
                        print(self.playerHand!)
                    }
                })
            }.navigationTitle("Olar")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
