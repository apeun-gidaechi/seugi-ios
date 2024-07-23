import SwiftUI
import Component
import BaseFeatureInterface
import Domain

public struct SettingProfileView: View {
    
    @EnvironmentObject private var appState: AppState
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            if let profile {
                ZStack(alignment: .bottomTrailing) {
                    SeugiAvatar(profile.member.picture, type: .extraLarge)
                    Image(icon: .addFill)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .seugiColor(.gray(.g600))
                }
                .padding(.vertical, 8)
                .button {
                    // TODO: Handle to pick image
                }
                .applyAnimation()
                HStack(spacing: 4) {
                    Text(profile.member.name)
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Image(icon: .writeLine)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .seugiColor(.gray(.g500))
                }
            }
            LazyVStack(spacing: 0) {
                SeugiListItem.icon(title: "회원탈퇴", icon: .expandRightLine, titleColor: .red(.r500))
                    .button {
                        // TODO: Handle remove member
                    }
                    .applyAnimation()
                SeugiDivider(thickness: .thick)
                SeugiListItem.icon(title: "개인정보 처리 방침", icon: .expandRightLine)
                    .button {
                        // TODO: Handle to open url
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "서비스 운영 정책", icon: .expandRightLine)
                    .button {
                        // TODO: Handle to open url
                    }
                    .applyAnimation()
            }
            Spacer()
        }
        .seugiTopBar("설정")
    }
}
