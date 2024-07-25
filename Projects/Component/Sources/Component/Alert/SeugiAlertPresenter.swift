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
        ZStack {
            content()
                .environmentObject(alertProvider)
            AlertView(
                isPresent: $alertProvider.showAlert,
                opacity: $backgroundOpacity,
                title: alertProvider.title,
                message: alertProvider.message,
                secondaryButton: alertProvider.secondaryButton,
                primaryButton: alertProvider.primaryButton
            ) {
                alertProvider.showAlert = false
            }
        }
    }
}

struct AlertView: View {
    
    @State private var scaleEffect: CGFloat = 1.2
    
    @Binding var isPresent: Bool
    @Binding var opacity: Double
    
    let title: String
    let message: String?
    let secondaryButton: AlertButton?
    let primaryButton: AlertButton?
    let dismiss: () -> Void
    
    var body: some View {
        if isPresent || opacity > 0 {
            VStack {
                Spacer()
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
                .seugiBackground(.sub(.white))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.06), radius: 12, y: 4)
                .onChange(of: isPresent) { isPresent in
                    withAnimation(.easeOut(duration: 0.2)) {
                        opacity = isPresent ? 1 : 0
                    }
                    if isPresent {
                        withAnimation(.easeOut(duration: 0.3)) {
                            scaleEffect = 1
                        }
                    } else {
                        withAnimation(.easeOut(duration: 0.2)) {
                            scaleEffect = 1.2
                        }
                    }
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 0.3)) {
                        opacity = 1
                    }
                    withAnimation(.easeOut(duration: 0.2)) {
                        scaleEffect = 1.0
                    }
                }
                .scaleEffect(scaleEffect)
                Spacer()
            }
            .opacity(opacity)
        }
    }
}
