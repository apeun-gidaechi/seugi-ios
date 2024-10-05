//
//  ImagePreview.swift
//  Image
//
//  Created by hhhello0507 on 9/27/24.
//

import SwiftUI
import Component
import UIKit
import NukeUI

// TODO: fix inner content가 ouuter content를 overflow 함
// 왜이런지 모르겠음
struct ImagePreview: View {
    let url: URL
    var body: some View {
        PinchScrollView {
            LazyImage(url: url) { phase in
                if phase.isLoading {
                    ProgressView()
                } else if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("이미지 로딩 실패")
                        .font(.body(.b2))
                        .seugiColor(.sub(.white))
                }
            }
        }
        .ignoresSafeArea()
        .seugiTopBar(
            title: "",
            colors: SeugiTopBarView.Colors(backgroundColor: .black, tintColor: .white)
        )
    }
}
