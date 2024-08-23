//
//  MainCoordinator.swift
//  MainFeatureInterface
//
//  Created by hhhello0507 on 8/22/24.
//

import SwiftUI
import DIContainer

struct MainCoordinator: View {
    
    @Inject private var chatDetailFactory: any ChatDetailFactory
    
    var body: some View {
        MainView()
            .navigationDestination(for: ChatDetailPath.self) { path in
                chatDetailFactory.makeView(room: path.room).eraseToAnyView()
            }
    }
}
