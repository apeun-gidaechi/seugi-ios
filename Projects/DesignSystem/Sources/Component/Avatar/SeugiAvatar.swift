//
//  AlimoAvatar.swift
//  App
//
//  Created by dgsw8th71 on 2/3/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

struct SeugiAvatar: View {
    
    var image: String?
    var type: SeugiAvatarType
    
    init(_ image: String?,
         type: SeugiAvatarType = .medium
    ) {
        self.image = image
        self.type = type
    }
    
    var body: some View {
        Image(image ?? DesignSystemAsset.personFill.name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: type.size, height: type.size)
            .clipShape(Circle())
    }
}
