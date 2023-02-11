////
////  ContentView.swift
////  NanoChallenge007
////
////  Created by Henrique Assis on 02/02/23.
////

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                ZStack {
                    Color.init(red: 0, green: 0.306, blue: 0.251)
                    Image("logo")
                        .resizable()
                        .frame(width: 130, height: 130)
                    }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                        }
                    }
                }
            }
        }
    }


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreen()
//    }
//}

