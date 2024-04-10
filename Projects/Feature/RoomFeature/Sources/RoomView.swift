import SwiftUI
import BaseFeature
import DesignSystem

public struct RoomView: View {
    
    @EnvironmentObject private var router: Router
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Button {
                    router.navigate(to: RoomDestination.roomDetail)
                } label: {
                    SeugiChatList(type: .people(memberCount: 10))
                }
                .applyAnimation()
                Button {
                    router.navigate(to: RoomDestination.roomDetail)
                } label: {
                    SeugiChatList(type: .people(memberCount: 4))
                }
                .applyAnimation()
            }
        }
        .seugiTopBar("단체")
        .button(.addFill) {
            router.navigate(to: RoomDestination.createRoom)
        }
        .button(.searchLine) {
            //
        }
        .hideBackButton()
    }
}
