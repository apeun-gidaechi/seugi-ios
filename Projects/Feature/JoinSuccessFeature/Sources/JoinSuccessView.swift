// bestswlkh0310

import SwiftUI
import DesignSystem
import BaseFeature

public struct JoinSuccessView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            
            Spacer()
            VStack(spacing: 0) {
                SeugiRoundedCircleImage.small(type: .fill(image: .studentActive))
                    .padding(.bottom, 16)
                Text("대구 소프트웨어 마이스터 고등학교")
                    .font(.seugi(.subtitle1))
                    .seugiColor(.sub(.black))
                Text("학생 213명 선생님 32명")
                    .font(.seugi(.body1))
                    .seugiColor(.gray(.g600))
            }
            
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                // TODO: handle join school
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .hideBackButton()
    }
}
