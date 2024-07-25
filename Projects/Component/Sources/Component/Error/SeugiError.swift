//
//  SeugiError.swift
//  Component
//
//  Created by hhhello0507 on 7/22/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiError: View {
    
    private let title: String
    private let image: SeugiImage
    
    public init(
        _ title: String,
        image: SeugiImage
    ) {
        self.title = title
        self.image = image
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            Image(image: image)
                .resizable()
                .frame(width: 64, height: 64)
            Text(title)
                .font(.subtitle(.s2))
                .seugiColor(.sub(.black))
        }
    }
}