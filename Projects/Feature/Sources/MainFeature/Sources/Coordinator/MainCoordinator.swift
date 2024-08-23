//
//  MainCoordinator.swift
//  MainFeatureInterface
//
//  Created by hhhello0507 on 8/22/24.
//

import SwiftUI
import DIContainer

struct MainCoordinator: View {
    
    var body: some View {
        MainView()
            .navigationDestination(for: ChatDetailPath.self) { path in
                ChatDetailCoordinator(room: path.room)
            }
    }
}
