import SwiftUI
import Component

struct RoomImagePreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(SeugiRoomImageType.allCases, id: \.self) {
                    SeugiRoomImage(type: $0, label: "제")
                }
                ForEach(SeugiRoomImageType.allCases, id: \.self) {
                    SeugiRoomImage("https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630", type: $0, label: "제")
                }
            }
        }
    }
}
