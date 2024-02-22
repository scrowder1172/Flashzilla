//
//  DetectBackgroundAppView.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import SwiftUI

struct DetectBackgroundAppView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var scenePhaseState: String = ""
    
    var body: some View {
        Text("Check scene phase: \(scenePhaseState)")
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Active")
                    scenePhaseState = "Active"
                } else if newPhase == .inactive {
                    print("Inactive")
                    scenePhaseState = "Inactive"
                } else if newPhase == .background {
                    print("Background")
                    scenePhaseState = "Background"
                }
            }
    }
}

#Preview {
    DetectBackgroundAppView()
}
