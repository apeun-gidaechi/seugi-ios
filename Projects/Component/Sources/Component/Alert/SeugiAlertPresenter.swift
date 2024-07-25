import SwiftUI
import SwiftUIUtil

public struct SeugiAlertPresenter<C: View>: View {
    
    @StateObject private var alertProvider = AlertProvider()
    
    @Binding private var backgroundOpacity: Double
    private let content: () -> C
    
    public init(
        provider: AlertProvider = .init(),
        backgroundOpacity: Binding<Double>,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._alertProvider = .init(wrappedValue: provider)
        self._backgroundOpacity = backgroundOpacity
        self.content = content
    }
    
    public var body: some View {
        AlertView(
            isPresent: $alertProvider.showAlert,
            opacity: $backgroundOpacity,
            title: alertProvider.title,
            message: alertProvider.message,
            secondaryButton: alertProvider.secondaryButton,
            primaryButton: alertProvider.primaryButton
        ) {
            alertProvider.showAlert = false
        } content: {
            content()
                .environmentObject(alertProvider)
        }
    }
}

struct AlertView<C: View>: View {
    
    @State private var scaleEffect: CGFloat = 1.2
    
    @Binding var isPresent: Bool
    @Binding var opacity: Double
    
    let title: String
    let message: String?
    let secondaryButton: AlertButton?
    let primaryButton: AlertButton?
    let dismiss: () -> Void
    let content: () -> C
    
    var body: some View {
        BaseModal(
            isPresent: $isPresent,
            opacity: $opacity,
            modalContent: {
                VStack(spacing: 18) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title)
                            .font(.subtitle(.s1))
                            .seugiColor(.sub(.black))
                        if let message = message {
                            Text(message)
                                .font(.subtitle(.s2))
                                .seugiColor(.sub(.black))
                        }
                    }
                    .toLeading()
                    .padding(4)
                    HStack(spacing: 8) {
                        if let secondaryButton {
                            if let primaryButton {
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
                            if let primaryButton {
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
            },
            content: content
        )
    }
}
