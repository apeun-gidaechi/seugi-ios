import SwiftUI
import SwiftUIUtil

public struct SeugiAlertPresenter<C: View>: View {
    
    @StateObject private var alertProvider = AlertProvider()
    private let content: () -> C
    
    public init(
        provider: AlertProvider = .init(),
        @ViewBuilder content: @escaping () -> C
    ) {
        self._alertProvider = .init(wrappedValue: provider)
        self.content = content
    }
    
    private func dismiss() {
        alertProvider.showAlert = false
    }
    
    public var body: some View {
        BaseModal(
            isPresent: $alertProvider.showAlert
        ) {
            VStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(alertProvider.title)
                        .font(.subtitle(.s1))
                        .seugiColor(.sub(.black))
                    if let message = alertProvider.message {
                        Text(message)
                            .font(.subtitle(.s2))
                            .seugiColor(.sub(.black))
                    }
                }
                .toLeading()
                .padding(4)
                HStack(spacing: 8) {
                    if let secondaryButton = alertProvider.secondaryButton {
                        if let primaryButton = alertProvider.primaryButton {
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
                            .applyAnimation()
                            .toTrailing()
                        }
                    } else {
                        if let primaryButton = alertProvider.primaryButton {
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
                            .applyAnimation()
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
                            .applyAnimation()
                            .toTrailing()
                        }
                    }
                }
            }
            .padding(18)
            .frame(width: 328)
        } content: {
            content()
                .environmentObject(alertProvider)
        }
    }
}
