import SwiftUI

import SwiftUIUtil

public struct SeugiBottomNavigation: View {
    @Binding private var selection: Int
    private var tabs: [Page]
    
    public init(
        selection: Binding<Int>,
        @Page.Builder tabs: () -> [Page]
    ) {
        self._selection = selection
        self.tabs = tabs()
    }
    
    public var body: some View {
        ZStack {
            ForEach(tabs.indices, id: \.self) { index in
                tabs[index].content
                    .opacity(index == selection ? 1 : 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .bottomGradientMask()
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 0) {
                ForEach(tabs.indices, id: \.self) { index in
                    BottomNavigationCell(page: tabs[index], selected: selection == index)
                        .frame(height: 64)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .button {
                            selection = index
                        }
                        .scaledButtonStyle()
                }
            }
            .frame(height: 64)
            .background(.white)
            .cornerRadius(18, corners: .allCorners)
            .shadow(color: Color.black.opacity(0.06), radius: 18, y: 2)
            .onChange(of: selection) { _ in
                let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                impactMed.impactOccurred()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: 400)
        }
    }
}
