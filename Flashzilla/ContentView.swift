//
//  ContentView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset: Double = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) private var accessibilityDifferentiateWithoutColor
    
    @State private var cards: [Card] = Array<Card>(repeating: .example, count: 10)
    @State private var cards2: [Card] = [Card](repeating: .example, count: 10)
    
    var body: some View {
        ZStack {
            Image(.appBackground)
            
            VStack {
                Text("Timer Placeholder")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(.black)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { cardIndex in
                        CardView(card: cards[cardIndex]) {
                            withAnimation {
                                removeCard(at: cardIndex)
                            }
                        }
                        .stacked(at: cardIndex, in: cards.count)
                    }
                }
            }
            
            if accessibilityDifferentiateWithoutColor {
                VStack {
                    Spacer()
                    
                    HStack {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

#Preview {
    ContentView()
}
