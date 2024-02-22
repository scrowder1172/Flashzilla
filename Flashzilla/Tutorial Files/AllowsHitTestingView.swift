//
//  AllowsHitTestingView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import SwiftUI

struct AllowsHitTestingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300)
                .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped!")
                }
        }
        
        VStack {
            Text("Hello")
            Spacer()
                .frame(height: 100)
            Text("World")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
        .border(.black)
    }
}

#Preview {
    AllowsHitTestingView()
}
