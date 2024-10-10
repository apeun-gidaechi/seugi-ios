import SwiftUI
import Combine

import SwiftUIUtil

struct SeugiAlertPresenter<C: View>: ModalViewProtocol {
    
    public typealias P = AlertProvider
    @StateObject private var provider: AlertProvider
    
    let content: () -> C
    
    public init(
        provider: AlertProvider,
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
                VStack(spacing: 18) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let alert = provider.alert {
                            Text(alert.title)
                                .font(.subtitle(.s1))
                                .seugiColor(.sub(.black))
                            if let message = alert.message {
                                Text(message)
                                    .font(.subtitle(.s2))
                                    .seugiColor(.sub(.black))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    HStack(spacing: 8) {
                        if let secondaryButton = provider.alert?.secondaryButton {
                            if let primaryButton = provider.alert?.primaryButton {
                                SeugiButton.large(secondaryButton.title, type: .gray) {
                                    secondaryButton.action()
                                    dismiss()
                                }
                                SeugiButton.large(primaryButton.title, type: .primary) {
                                    primaryButton.action()
                                    dismiss()
                                }
                            } else {
                                Button {
                                    secondaryButton.action()
                                    dismiss()
                                } label: {
                                    Text(secondaryButton.title)
                                        .seugiColor(.primary(.p500))
                                        .font(.subtitle(.s2))
                                        .frame(height: 36)
                                        .padding(.horizontal, 12)
                                }
                                .scaledButtonStyle()
                                .toTrailing()
                            }
                        } else {
                            if let primaryButton = provider.alert?.primaryButton {
                                Button {
                                    primaryButton.action()
                                    dismiss()
                                } label: {
                                    Text(primaryButton.title)
                                        .seugiColor(.primary(.p500))
                                        .font(.subtitle(.s2))
                                        .frame(height: 36)
                                        .padding(.horizontal, 12)
                                }
                                .scaledButtonStyle()
                                .toTrailing()
                            } else {
                                Button {
                                    dismiss()
                                } label: {
                                    Text("닫기")
                                        .seugiColor(.primary(.p500))
                                        .font(.subtitle(.s2))
                                        .frame(height: 36)
                                        .padding(.horizontal, 12)
                                }
                                .scaledButtonStyle()
                                .toTrailing()
                            }
                        }
                    }
                }
                .padding(18)
                .frame(width: 328)
            }, 
            content: content
        )
    }
}
