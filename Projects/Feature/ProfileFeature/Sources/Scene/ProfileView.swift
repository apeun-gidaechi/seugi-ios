import SwiftUI
import Component
import Domain
import BaseFeatureInterface

public struct ProfileView: View {
    
    @EnvironmentObject private var appState: AppState
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HStack(spacing: 10) {
                    SeugiAvatar(type: .medium)
                    Text(profile?.member.name ?? "")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                    Image(icon: .settingFill)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.gray(.g500))
                        .frame(width: 32, height: 32)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                SeugiDivider(thickness: .thick)
                makeProfileCell()
                SeugiDivider(thickness: .thin).padding(.horizontal, 16)
                makeProfileCell()
                SeugiDivider(thickness: .thin).padding(.horizontal, 16)
                makeProfileCell()
                SeugiDivider(thickness: .thin).padding(.horizontal, 16)
                makeProfileCell()
            }
        }
        .seugiBackground(.sub(.white))
        .seugiTopBar("내 프로필")
        .hideBackButton()
    }
}

private func makeProfileCell() -> some View {
    VStack(spacing: 0) {
        HStack {
            Text("상태메세지")
                .font(.body(.b1))
                .seugiColor(.gray(.g500))
            Spacer()
            Image(icon: .writeLine)
                .resizable()
                .renderingMode(.template)
                .seugiColor(.gray(.g500))
                .frame(width: 20, height: 20)
        }
        .padding(.horizontal, 20)
        SeugiListItem.normal(title: "대소고 어딘가")
    }
}
