//
//  ContentView.swift
//  ApenasUmTeste
//
//  Created by Henrique Assis on 10/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .overlay(alignment: .bottom) {
                        Circle().foregroundColor(.red)
                            
                    }
            Spacer()
        }
        .toolbar {
            <#code#>
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
