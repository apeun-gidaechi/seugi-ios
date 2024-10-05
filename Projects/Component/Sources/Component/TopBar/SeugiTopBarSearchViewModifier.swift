import SwiftUI

struct SeugiTopBarSearchViewModifier: SeugiTopBarViewModifier {
    private let hint: String
    @Binding private var text: String
    @Binding private var isSearching: Bool
    
    init(
        hint: String,
        text: Binding<String>,
        isSearching: Binding<Bool>
    ) {
        self.hint = hint
        self._text = text
        self._isSearching = isSearching
    }
    
    func body(content: SeugiTopBarView) -> SeugiTopBarView {
        var content = content
        if isSearching {
            content = content
                .copy(
                    title: .some(nil),
                    showBackButton: true,
                    subView: AnyView(subView()),
                    onBackAction: onBackAction,
                    onTapGesture: onTapGesture
                )
        }
        
        if isSearching {
            content = content.copy(buttons: [])
        } else {
            content = content.copy(buttons: [searchButton] + content.buttons)
        }
        return content
    }
    
    var searchButton: SeugiTopBarButton {
        SeugiTopBarButton(icon: .searchLine) {
            withAnimation {
                isSearching = true
            }
        }
    }
    
    func subView() -> some View {
        struct SearchView: View {
            let hint: String
            @Binding var text: String
            @FocusState private var focused
            
            var body: some View {
                TextField(hint, text: $text)
                    .focused($focused)
                    .onAppear {
                        focused = true
                    }
            }
        }
        return SearchView(hint: hint, text: $text)
    }
    
    func onBackAction() {
        withAnimation {
            isSearching = false
        }
    }
    
    func onTapGesture() {
        withAnimation {
            isSearching = false
            text = ""
        }
    }
}

public extension SeugiTopBarView {
    // SeugiTopBarView.buttons 뒤에 나둬야 button이 생김
    func searchable(
        _ hint: String,
        text: Binding<String>,
        isSearching: Binding<Bool>
    ) -> Self {
        self.modifier(
            SeugiTopBarSearchViewModifier(
                hint: hint,
                text: text,
                isSearching: isSearching
            )
        )
    }
}
