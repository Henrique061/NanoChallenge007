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
    
    var body: some View {
        VStack {
            HomeView()
        }
        .padding()
        Text("Ola")
            .padding()
            .onAppear() {
                self.deckUtils.getReshuffle(deckid: "lvqblg4m6zc8", completion: { (reshuffle) in
                    self.gameDeck = reshuffle
                    print(self.gameDeck!)
                })
            }.navigationTitle("Olar")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
