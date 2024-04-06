import SwiftUI
import BaseFeature
import DesignSystem

public struct FirstCreateRoomView: View {
    
    private let navigateToSecondCreateRoom: () -> Void
    
    public init(
        navigateToSecondCreateRoom: @escaping () -> Void
    ) {
        self.navigateToSecondCreateRoom = navigateToSecondCreateRoom
    }
    
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
                navigateToSecondCreateRoom()
            }
        }
    }
}
