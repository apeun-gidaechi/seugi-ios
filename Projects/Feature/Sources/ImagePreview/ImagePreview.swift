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

// TODO: fix inner content가 ouuter content를 overflow 함. 왜이런지 모르겠음
struct ImagePreview: View {
    struct Path: Hashable {
        static func == (lhs: ImagePreview.Path, rhs: ImagePreview.Path) -> Bool {
            lhs.uuid == rhs.uuid
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.uuid)
        }
        private let uuid: UUID = UUID()
        let url: URL
        let bottomButtons: [BottomButton]
        let topBarbuttons: () -> [SeugiTopBarButton]
        
        init(
            url: URL,
            bottomButtons: [BottomButton] = [],
            @SeugiTopBarButton.Builder topBarbuttons: @escaping () -> [SeugiTopBarButton] = { [] }
        ) {
            self.url = url
            self.bottomButtons = bottomButtons
            self.topBarbuttons = topBarbuttons
        }
    }
    struct BottomButton {
        let icon: SeugiIconography
        let action: () -> Void
    }
    
    private let url: URL
    private let bottomButtons: [BottomButton]
    private let topBarbuttons: () -> [SeugiTopBarButton]
    
    init(path: Path) {
        self.url = path.url
        self.bottomButtons = path.bottomButtons
        self.topBarbuttons = path.topBarbuttons
    }
    
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
            colors: .init(
                backgroundColor: .seugi(.sub(.black)),
                tintColor: .seugi(.sub(.white))
            )
        )
        .buttons(buttons: topBarbuttons)
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 8) {
                ForEach(self.bottomButtons.indices, id: \.self) { index in
                    let button = self.bottomButtons[index]
                    Button(action: button.action) {
                        Image(icon: button.icon)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .seugiColor(.sub(.white))
                            .padding(8)
                    }
                }
            }
        }
    }
}
