import SwiftUI

import SwiftUIUtil

struct SeugiTimePickerPresenter<C: View>: View {
    
    @StateObject private var provider: TimePickerProvider
    let content: () -> C
    
    init(
        provider: TimePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._provider = .init(wrappedValue: provider)
        self.content = content
    }
    
    func dismiss() {
        provider.isPresent = false
    }
    
    public var body: some View {
        BaseModal(
            isPresent: $provider.isPresent,
            modalContent: {
                VStack(spacing: 16) {
                    if let title = provider.title {
                        Text(title)
                            .font(.subtitle(.s1))
                            .seugiColor(.sub(.black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    DatePicker("", selection: .constant(.now))
                        .datePickerStyle(.wheel)
                    SeugiButton.large("선택", type: .primary) {
                        provider.action?()
                        dismiss()
                    }
                }
                .padding(24)
                .frame(width: 336)
            },
            content: content
        )
    }
}
