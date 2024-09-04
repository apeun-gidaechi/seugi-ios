import SwiftUI
import Component
import DIContainer

public struct StartView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var appDelegate: AppDelegate
    
    @StateObject private var viewModel = StartViewModel()
    @StateObject private var appleLoginViewModel = AppleLoginViewModel()
    @StateObject private var googleLoginViewModel = GoogleLoginViewModel()
    
    @State private var offsetY1: CGFloat = 16
    @State private var opacity1 = 0.0
    @State private var offsetY2: CGFloat = 16
    @State private var opacity2 = 0.0
    @State private var isPresented = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            SeugiGradientSystem.primary
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image(image: .cloud1)
                    .toTrailing()
                    .opacity(opacity1)
                    .offset(y: offsetY1)
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("스기")
                        .font(.display(.d1))
                        .seugiColor(.sub(.white))
                    Text("학생, 선생님 모두 함께하는\n스마트 스쿨 플랫폼")
                        .multilineTextAlignment(.leading)
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.white))
                }
                .toLeading()
                .padding(.leading, 24)
                .opacity(opacity1)
                .offset(y: offsetY1)
                Spacer()
                Image(image: .cloud2)
                    .toLeading()
                    .opacity(opacity2)
                    .offset(y: offsetY2)
                Spacer()
                SeugiButton.large("시작하기", type: .shadow) {
                    isPresented = true
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 20)
                .opacity(opacity2)
                .offset(y: offsetY2)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(0.25))
            withAnimation(.easeInOut(duration: 1)) {
                offsetY1 = 0
                opacity1 = 1
            }
            try? await Task.sleep(for: .seconds(0.75))
            withAnimation(.easeInOut(duration: 1)) {
                offsetY2 = 0
                opacity2 = 1
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack(spacing: 8) {
                SeugiButton.large("이메일로 계속하기", type: .black) {
                    isPresented = false
                    router.navigate(to: OnboardingDestination.emailSignIn)
                }
                .padding(.top, 20)
                AppleLoginButton {
                    appleLoginViewModel.signIn { idToken, _ in
                        isPresented = false
                        viewModel.signIn(token: idToken, provider: .apple)
                    } failureCompletion: {
                        isPresented = false
                        viewModel.signInFlow = .failure(.unknown)
                    }
                }
                GoogleLoginButton {
                    googleLoginViewModel.signIn { result in
                        appDelegate.currentAuthorizationFlow = result
                    } successCompletion: { state in
                        isPresented = false
                        guard let code = state.lastAuthorizationResponse.authorizationCode else {
                            return
                        }
                        viewModel.signIn(token: code, provider: .google)
                    } failureCompletion: {
                        isPresented = false
                        viewModel.signInFlow = .failure(.unknown)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .presentationDetents([.height(256)])
        }
        .eraseToAnyView()
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .signInSuccess(let token):
                    appState.accessToken = String(token.accessToken.split(separator: " ")[1])
                    appState.refreshToken = String(token.refreshToken.split(separator: " ")[1])
                }
            }
        }
        .onChange(of: viewModel.signInFlow) { _ in } failure: { _ in
            alertProvider.present("로그인 실패")
                .message("잠시 후 다시 시도해 주세요")
                .show()
        }
    }
}
