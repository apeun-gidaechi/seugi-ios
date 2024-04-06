import SwiftUI
import BaseFeature
import DesignSystem

public struct RoomView: View {
    
    private var navigateToRoomDetail: () -> Void
    private var navigateToCreateRoom: () -> Void
    
    public init(
        navigateToRoomDetail: @escaping () -> Void,
        navigateToCreateRoom: @escaping () -> Void
    ) {
        self.navigateToRoomDetail = navigateToRoomDetail
        self.navigateToCreateRoom = navigateToCreateRoom
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Button {
                    navigateToRoomDetail()
                } label: {
                    SeugiChatList(type: .people(memberCount: 10))
                }
                .applyAnimation()
                Button {
                    navigateToRoomDetail()
                } label: {
                    SeugiChatList(type: .people(memberCount: 4))
                }
                .applyAnimation()
            }
        }
        .seugiToolbar(
            "단체",
            icon1: DesignSystemAsset.addFill.swiftUIImage,
            icon1ButtonTapped: {
                navigateToCreateRoom()
            },
            icon2: DesignSystemAsset.searchLine.swiftUIImage,
            icon2ButtonTapped: {}
        )
    }
}
