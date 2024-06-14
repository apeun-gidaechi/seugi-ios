//
//  RoomCoordinator.swift
//  RoomFeature
//
//  Created by dgsw8th71 on 4/10/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import RoomFeatureInterface
import DIContainer
import CreateRoomFeatureInterface

struct RoomCoordinator: View {
    
    @Inject private var createRoomFactory: any CreateRoomFactory
    
    var body: some View {
        RoomView()
            .navigationDestination(for: RoomDestination.self) {
                switch $0 {
                case .createRoom: createRoomFactory.makeView().eraseToAnyView()
                case .roomDetail: EmptyView()
                }
            }
    }
}
