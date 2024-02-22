//
//  TimerTestingView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import SwiftUI
import Combine

struct TimerTestingView: View {
    
    let continousTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerCancellable: Cancellable?
    @State private var timeText: String = ""
    
    @State private var doubleTime: Double = 0.0
    @State private var stopWatchCancellable: Cancellable?
    
    var body: some View {
        
        VStack {
            Text("Hello, World!")
                .onReceive(continousTimer) { time in
                    print("The time is now \(time)")
                }
            Button("Stop continuous timer") {
                continousTimer.upstream.connect().cancel()
                print("Continous timer canceled")
            }
            .buttonStyle(.borderedProminent)
        }
        
        Divider()
            .padding(.vertical, 20)
        
        Button("Start Timer") {
            startTimer()
        }
        .buttonStyle(.borderedProminent)
        Button("Stop Timer") {
            stopTimer()
        }
        .buttonStyle(.bordered)
        Text("Timer: \(timeText)")
        
        Divider()
            .padding(.vertical, 20)
        
        HStack {
            Button("Start") {
                let stopWatchTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                stopWatchCancellable = stopWatchTimer
                    .sink { time in
                        doubleTime += 0.01
                    }
            }
            .frame(width: 50, height: 50)
            .background(.green)
            .foregroundStyle(.white)
            .clipShape(Circle())
            
            VStack {
                Text("Stop watch:")
                Text("\(doubleTime.formatted())")
            }
            
            
            Button("Stop") {
                stopWatchCancellable?.cancel()
            }
            .frame(width: 50, height: 50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(Circle())
            
            Button("Reset") {
                stopWatchCancellable?.cancel()
                doubleTime = 0.0
            }
            .frame(width: 50, height: 50)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Circle())
        }
        
        
        
    }
    
    func startTimer() {
        let stopStopTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        timerCancellable = stopStopTimer
            .sink { time in
                timeText = "\(time)"
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
    }
}

#Preview {
    TimerTestingView()
}
