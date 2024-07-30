//
//  ErrorPreview.swift
//  Component
//
//  Created by hhhello0507 on 7/22/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct ErrorPreview: View {
    var body: some View {
        VStack {
            SeugiError("페이지를 찾을 수 없습니다", image: .faceWithDiagonalMouth)
            SeugiError("페이지를 찾을 수 없습니다", image: .kissingFaceWithClosedEyes)
            SeugiError("페이지를 찾을 수 없습니다", image: .sadButRelievedFace)
        }
    }
}
