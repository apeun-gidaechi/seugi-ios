//
//  RoomCoordinator.swift
//  RoomFeature
//
//  Created by dgsw8th71 on 4/10/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import RoomFeatureInterface
import DIContainerInterface

struct RoomCoordinator: View {
    
    var body: some View {
        RoomView()
            .navigationDestination(for: RoomDestination.self) { _ in
                EmptyView()
            }
    }
}
