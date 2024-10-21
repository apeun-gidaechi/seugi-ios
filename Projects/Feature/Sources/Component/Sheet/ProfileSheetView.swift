import SwiftUI
import Component
import Domain

struct ProfileSheetView {
    private let profile: RetrieveProfile
    private let sendMessageAction: () -> Void
    
    init(
        profile: RetrieveProfile,
        sendMessageAction: @escaping () -> Void
    ) {
        self.profile = profile
        self.sendMessageAction = sendMessageAction
    }
}

extension ProfileSheetView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                SeugiAvatar(profile.member.picture, type: .medium)
                Text(profile.nameAndNick)
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                Spacer()
                SeugiButton.small("채팅", type: .black, action: sendMessageAction)
                .scaledButtonStyle()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            SeugiDivider(thickness: .thick)
            ProfileCell("상태메세지", value: profile.status)
            ProfileCell("닉네임", value: profile.nick)
            ProfileCell("직위", value: profile.spot)
            ProfileCell("소속", value: profile.belong)
            ProfileCell("휴대전화번호", value: profile.phone)
            ProfileCell("유선전화번호", value: profile.wire)
            ProfileCell("근무위치", value: profile.location)
        }
    }
}
