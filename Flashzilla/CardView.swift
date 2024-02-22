//
//  CardView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import SwiftUI

struct CardView: View {
    
    let card: Card
    
    @State private var isShowingAnswer: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

#Preview {
    CardView(card: .example)
}
