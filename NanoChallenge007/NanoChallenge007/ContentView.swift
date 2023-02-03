//
//  ContentView.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var reshuffle : ShuffleModel? = nil
    
    var body: some View {
        Text("Ola")
            .padding()
            .onAppear() {
                DeckUtils().getReshuffle { (reshuffle) in
                    self.reshuffle = reshuffle
                }
            }.navigationTitle("Olar")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
