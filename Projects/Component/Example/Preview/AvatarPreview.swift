import SwiftUI
import Component

struct AvatarPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(SeugiAvatarType.allCases, id: \.self) {
                    SeugiAvatar(type: $0)
                }
                ForEach(SeugiAvatarType.allCases, id: \.self) {
                    SeugiAvatar("https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630", type: $0)
                }
            }
        }
    }
}
