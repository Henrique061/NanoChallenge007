//
//  ContentView.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var deckUtils = DeckUtils()
    
    var body: some View {
        Text("Ola")
            .padding()
            .onAppear() {
                deckUtils.getReshuffle(deckid: "lvqblg4m6zc8", completion: { (reshuffle) in
                    self.deckUtils.reshuffle = reshuffle
                    print(self.deckUtils.reshuffle!)
                })
            }.navigationTitle("Olar")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
