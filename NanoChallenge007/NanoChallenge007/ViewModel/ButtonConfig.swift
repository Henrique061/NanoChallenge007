//
//  ButtonConfig.swift
//  NanoChallenge007
//
//  Created by Barbara Argolo on 07/02/23.
//

import SwiftUI

struct Buttons: View {
    private var completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    var body: some View {
        HStack {
            Button(action: {
                completion()
            }) {
                Text("Hit")
                
            }
            .frame(alignment: .bottom)
            .buttonStyle(ButtonConfig())
            
            Button(action: {}) {
                Text("Stand")
            }
            .frame(alignment: .bottom)
            .buttonStyle(ButtonConfig())
        }.frame(maxHeight: .infinity, alignment: .bottom)
    }
}


struct ButtonConfig: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(height: 44)
            .frame(maxWidth: .infinity, alignment: .bottom)
            .background(Color.init(red: 0.704, green: 0.494, blue: 0.246))
            .cornerRadius(8)
    }
}

