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

struct ImagePreview: View {
    let url = URL(string: "https://seugi.s3.ap-northeast-2.amazonaws.com/IMG/68574c9d-0860-442a-b918-75bc7e049513-1000010272.jpg.jpg")!
    var body: some View {
        PinchScrollView {
            LazyImage(url: url) { phase in
                if phase.isLoading {
                    ProgressView()
                } else if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    SeugiError("이미지 로딩 실패")
                }
            }
        }
        .ignoresSafeArea()
        .seugiTopBar("", background: .black, tintColor: .white)
    }
}
