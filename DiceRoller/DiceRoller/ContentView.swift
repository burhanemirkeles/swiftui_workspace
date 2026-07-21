//
//  ContentView.swift
//  DiceRoller
//
//  Created by Infonal on 21.07.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfDices: Int = 1
    
    var body: some View {
        VStack {
            Text("Dice Roller")
                .font(.largeTitle.lowercaseSmallCaps())
                .foregroundStyle(.white)
            
            HStack {
                ForEach(1...numberOfDices, id: \.description) { _ in
                    DiceView()
                }
            }
            HStack {
                Button("Remove Dice", systemImage: "minus.circle.fill") {
                    withAnimation {
                        numberOfDices -= 1
                    }
                }
                .disabled(numberOfDices == 1)
                Button("Add Dice", systemImage: "plus.circle.fill") {
                    withAnimation {
                        numberOfDices += 1
                    }
                }
                .disabled(numberOfDices == 5)
            }
            .padding()
            .labelStyle(.iconOnly)
            .font(.title)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appBackground)
        .tint(.white)
    }
}

#Preview {
    ContentView()
}
