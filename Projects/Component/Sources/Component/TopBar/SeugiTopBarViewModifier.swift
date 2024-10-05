import SwiftUI

protocol SeugiTopBarViewModifier {
    // ViewModifier 베꼈음
    // TODO: @preconcurrency 이런 게 뭐하는 애인지 공부 하기
    @ViewBuilder @MainActor @preconcurrency func body(content: SeugiTopBarView) -> SeugiTopBarView
}

extension SeugiTopBarView {
    func modifier<M>(_ modifier: M) -> SeugiTopBarView where M: SeugiTopBarViewModifier {
        return modifier.body(content: self)
    }
}
