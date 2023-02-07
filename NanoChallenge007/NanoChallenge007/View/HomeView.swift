//
//  HomeView.swift
//  NanoChallenge007
//
//  Created by Henrique Assis on 03/02/23.
//

import Foundation
import SwiftUI



struct HomeView: View {
    @State private var showBottomSheet: Bool = false
    @State var gameDeck: ShuffleModel? = nil
    
    var body: some View {
      
        
        ZStack {
            Color.init(red: 0.214, green: 0.458, blue: 0.174)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Buttons()
                }
                
                .padding(.horizontal, 20)
               
                HStack(alignment: .center) {
                    ZStack(alignment: .center) {
                        Image("3S")
                            .resizable()
                            .frame(width: 70, height: 85, alignment: .bottom)
                    }
                }
                ScoreLabel().padding(.vertical, 35)
                    
                HStack(alignment: .center) {
                    ZStack(alignment: .center) {
                        Image("3S")
                            .resizable()
                            .frame(width: 70, height: 85, alignment: .bottom)
                    }
                }.padding(.top, 200)
                    HStack {
                        Buttons()
                    }
                    .padding(.horizontal, 20)
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




//            ZStack{
//                Button(action: {
//                    DeckUtils().getShuffle(completion: { (shuffle) in
//                        self.gameDeck = shuffle
//                    })
//
//                }, label: {
//                    Image(systemName: "play.fill")
//                })
//
