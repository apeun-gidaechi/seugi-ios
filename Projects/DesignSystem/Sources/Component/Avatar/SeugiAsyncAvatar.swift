//
//  AlimoAsyncAvatar.swift
//  App
//
//  Created by dgsw8th71 on 3/6/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

struct SeugiAsyncAvatar: View {
    
    var url: String
    var type: SeugiAvatarType
    
    init(_ url: String,
         type: SeugiAvatarType = .medium
    ) {
        self.url = url
        self.type = type
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: type.size, height: type.size)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .seugiForeground(.gray(.g100))
                .frame(width: type.size, height: type.size)
        }
    }
}
