//
//  ChatDetailCoordiantor.swift
//  ChatDetailFeature
//
//  Created by dgsw8th71 on 4/10/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

struct ChatDetailCoordinator: View {
    
    private let roomId: String
    
    init(roomId: String) {
        self.roomId = roomId
    }
    
    var body: some View {
        ChatDetailView(roomId: roomId)
    }
}
