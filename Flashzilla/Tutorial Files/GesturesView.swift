//
//  GesturesView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import SwiftUI

struct GesturesView: View {
    
    @State private var gesture: String = ""
    
    @State private var currentZoomAmount: Double = 0.0
    @State private var finalZoomAmount: Double = 1.0
    
    @State private var currentAngle: Angle = Angle.zero
    @State private var finalAngle: Angle = Angle.zero
    
    @State private var circleOffset: CGSize = CGSize.zero
    @State private var circleIsDragging: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack {
                    Text("Zoom: \((finalZoomAmount - 1).formatted())")
                    Button("Reset Zoom") {
                        finalZoomAmount = 1
                    }
                    .buttonStyle(.borderedProminent)
                    Button("", systemImage: "arrow.up") {
                        finalZoomAmount = 2
                    }
                    .buttonStyle(.borderedProminent)
                    Button("", systemImage: "arrow.down") {
                        finalZoomAmount = 0.5
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                HStack {
                    Text("Angle: \(finalAngle.degrees.formatted())")
                    Button("Reset Angle") {
                        finalAngle = .zero
                    }
                    .buttonStyle(.borderedProminent)
                    Button("", systemImage: "arrow.up") {
                        finalAngle = .degrees(90.0)
                    }
                    .buttonStyle(.borderedProminent)
                    Button("", systemImage: "arrow.down") {
                        finalAngle = .degrees(-90.0)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                HStack {
                    Text("On Tap Gesture")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            gesture = "On Tap"
                        }
                    
                    Text("Double Tap")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onTapGesture(count: 2) {
                            gesture = "Double tap"
                        }
                    
                    Text("Long Press")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onLongPressGesture {
                            gesture = "Long Press"
                        }
                    
                    Text("3sec Long Press")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onLongPressGesture(minimumDuration: 3) {
                            gesture = "3 sec Long Press"
                        }
                }
                
                HStack {
                    Text("3sec Long Press w/ Trigger")
                        .frame(width: 100, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onLongPressGesture(minimumDuration: 3) {
                            gesture = "3 sec Long Press completed"
                        } onPressingChanged: { inProgress in
                            gesture = "3 sec Long Press started"
                        }
                    
                    Text("Zoom")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            gesture = "Magnify"
                        }
                        .scaleEffect(finalZoomAmount + currentZoomAmount)
                        .gesture(
                            MagnifyGesture()
                                .onChanged { value in
                                    currentZoomAmount = value.magnification - 1
                                }
                                .onEnded { value in
                                    finalZoomAmount += currentZoomAmount
                                    currentZoomAmount = 0.0
                                }
                        )
                    
                    Text("Rotate")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            gesture = "Rotation"
                        }
                        .rotationEffect(currentAngle + finalAngle)
                        .gesture(
                            RotateGesture()
                                .onChanged { value in
                                    currentAngle = value.rotation
                                }
                                .onEnded { value in
                                    finalAngle += currentAngle
                                    currentAngle = .zero
                                }
                        )
                }
                
                HStack {
                    Text("Child")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            gesture = "Child Tapped"
                        }
                    Text("Child2")
                        .frame(width: 75, height: 75)
                        .border(.black)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            gesture = "Child 2 Tapped"
                        }
                }
                .onTapGesture {
                    gesture = "Parent tapped"
                }
                .frame(width: 200, height: 100)
                .background(.yellow)
            }
            
            HStack {
                Text("Weak Child")
                    .frame(width: 75, height: 75)
                    .border(.black)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        gesture = "Weak Child Tapped"
                    }
            }
            .highPriorityGesture (
                TapGesture()
                    .onEnded {
                        gesture = "Strong Parent"
                    }
            )
            .frame(width: 100, height: 100)
            .background(.yellow)
            
            HStack {
                Text("Child/Parent")
                    .frame(width: 75, height: 75)
                    .border(.black)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        gesture = "Child/Parent"
                    }
            }
            .gesture(
                TapGesture()
                    .onEnded {
                        gesture = "Parent/Child"
                    }
            )
            .frame(width: 100, height: 100)
            .background(.yellow)
            
            VStack {
                let dragGesture = DragGesture()
                    .onChanged { value in
                        circleOffset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            circleOffset = .zero
                            circleIsDragging = false
                        }
                    }
                
                let pressGesture = LongPressGesture()
                    .onEnded { value in
                        withAnimation {
                            circleIsDragging = true
                        }
                    }
                
                let combined = pressGesture.sequenced(before: dragGesture)
                
                ZStack{
                    Circle()
                        .fill(.red)
                        .frame(width: 150)
                    Text("Tap & hold to drag")
                }
                .scaleEffect(circleIsDragging ? 1.5 : 1)
                .offset(circleOffset)
                .gesture(combined)
            }
            .navigationTitle("Gesture: \(gesture)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GesturesView()
}
