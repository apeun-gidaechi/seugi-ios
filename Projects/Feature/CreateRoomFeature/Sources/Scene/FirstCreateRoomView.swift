import SwiftUI
import BaseFeatureInterface
import DesignSystem

public struct FirstCreateRoomView: View {
    
    @EnvironmentObject private var router: Router
    
    public var body: some View {
        VStack(spacing: 0) {
            Text("대충 여기 textfield")
                .padding(.vertical, 12)
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(0..<10, id: \.self) {
                        SeugiMemberList {
                            SeugiToggle(isOn: .constant(true), type: .checkbox(size: .large))
                        }
                        .id($0)
                    }
                }
            }
            Spacer()
        }
        .seugiTopBar("멤버 선택")
        .subView {
            SeugiButton.small("완료", type: .transparent) {
                router.navigate(to: CreateRoomDestination.secondCreateRoom)
            }
        }
    }
}
