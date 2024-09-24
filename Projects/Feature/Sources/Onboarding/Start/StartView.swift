import SwiftUI
import Component

public struct StartView: View {
    
    @Router private var router
    @AppState private var appState
    @EnvironmentObject private var alertProvider: AlertProvider
    
    @StateObject private var viewModel = StartViewModel()
    @StateObject private var appleLoginViewModel = AppleLoginViewModel()
    @StateObject private var googleLoginViewModel = GoogleLoginViewModel()
    
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
                    .fadeInEffect(time: 0.25)
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .fadeInEffect(time: 0.25)
                Spacer()
                Image(image: .cloud2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fadeInEffect(time: 0.75)
                Spacer()
                SeugiButton.large("시작하기", type: .shadow) {
                    isPresented = true
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 20)
                .fadeInEffect(time: 0.75)
            }
        }
        .sheet(isPresented: $isPresented) {
            sheet
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .signInSuccess(let token):
                    appState.accessToken = String(token.accessToken.split(separator: " ")[1])
                    appState.refreshToken = String(token.refreshToken.split(separator: " ")[1])
                }
            }
        }
        .onChangeFailure(of: viewModel.signInFlow) { _ in
            alertProvider.present("로그인 실패")
                .message("잠시 후 다시 시도해 주세요")
                .show()
        }
        .onChange(of: viewModel.signInFlow) { token in
            Log.info("StartView - 로그인 성공")
            let accessToken = String(token.accessToken.split(separator: " ")[1])
            let refreshToken = String(token.refreshToken.split(separator: " ")[1])
            withAnimation {
                appState.accessToken = accessToken
                appState.refreshToken = refreshToken
                appState.login()
                router.navigateToRoot()
            }
        } failure: { _ in
            alertProvider.present("로그인 실패")
                .message("아이디 혹은 비밀번호를 다시 확인해 주세요")
                .show()
        }
    }
    
    private var sheet: some View {
        VStack(spacing: 8) {
            SeugiButton.large("이메일로 계속하기", type: .black) {
                isPresented = false
                router.navigate(to: OnboardingDestination.emailSignIn)
            }
            .padding(.top, 20)
            AppleLoginButton {
                appleLoginViewModel.signIn { code, _ in
                    isPresented = false
                    viewModel.signIn(code: code, provider: .apple)
                } failureCompletion: {
                    isPresented = false
                    viewModel.signInFlow = .failure(.unknown)
                }
            }
            GoogleLoginButton {
                googleLoginViewModel.signIn { result in
                    isPresented = false
                    guard let code = result.serverAuthCode else {
                        return
                    }
                    viewModel.signIn(code: code, provider: .google)
                } failureCompletion: { _ in
                    isPresented = false
                    viewModel.signInFlow = .failure(.unknown)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .adjustedHeightSheet()
    }
}
