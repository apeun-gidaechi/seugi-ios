import SwiftUI
import BaseFeatureInterface
import DesignSystem
import Flow
import SwiftUIUtil

public struct FirstCreateRoomView: View {
    
    @EnvironmentObject private var router: Router
    @State private var contentSize: CGSize = .zero

    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                HFlow(itemSpacing: 4, rowSpacing: 4) {
                    ForEach(0..<30, id: \.self) { _ in
                        SeugiSelectingMember {}
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(4)
            .overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        contentSize = geo.size
                    }
                }
            )
            .scrollOnOverflow(300)
            .frame(height: min(contentSize.height, 300))
            .frame(minHeight: 52)
            .stroke(12, content: Color.seugi(.gray(.g300)))
            .padding(.horizontal, 16)
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(0..<10, id: \.self) { _ in
                        Button {} label: {
                            SeugiMemberList {
                                SeugiToggle(isOn: .constant(true), type: .checkbox(size: .large))
                            }
                        }
                        .applyAnimation()
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
        .onChange(of: contentSize.height) {
            print($0)
        }
    }
}
