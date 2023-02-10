//
//  ButtonConfig.swift
//  NanoChallenge007
//
//  Created by Barbara Argolo on 07/02/23.
//

import SwiftUI

struct Buttons: View {
    private var hitCompletion: () -> Void
    private var standCompletion: () -> Void
    
    init(hitCompletion: @escaping () -> Void, standCompletion: @escaping () -> Void) {
        self.hitCompletion = hitCompletion
        self.standCompletion = standCompletion
    }
    
    var body: some View {
        HStack {
            Button(action: {
                hitCompletion()
            }) {
                Text("Hit ⬇️")
                
            }
            .frame(alignment: .bottom)
            .buttonStyle(ButtonConfig(.hit))
            
            Button(action: {
                standCompletion()
            }) {
                Text("Stand ✋")
            }
            .frame(alignment: .bottom)
            .buttonStyle(ButtonConfig(.stand))
        }.frame(maxHeight: .infinity, alignment: .bottom)
    }
}

public enum ButtonType {
    case hit
    case stand
}

struct ButtonConfig: ButtonStyle {
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    
    init(_ buttonType: ButtonType) {
        if buttonType == .hit {
            self.r = 0.393
            self.g = 0.704
            self.b = 0.246
        }
        
        else {
            self.r = 0.904
            self.g = 0.139
            self.b = 0.139
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(height: 44)
            .frame(maxWidth: .infinity, alignment: .bottom)
            .background(Color.init(red: r, green: g, blue: b, opacity: 0.9))
            .cornerRadius(8)
    }
}

