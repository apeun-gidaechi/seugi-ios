import SwiftUI
import Component
import SwiftUtil

public struct StartView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var alertProvider: AlertProvider
    
    @StateObject private var viewModel = StartViewModel()
    @StateObject private var appleLoginViewModel = AppleLoginViewModel()
    @StateObject private var googleLoginViewModel = GoogleLoginViewModel()
    
    @State private var isPresented: Bool = false
    
    public init() {}
}

extension StartView: View {
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
        .sheet(isPresented: $isPresented, content: sheetContent)
        .onReceive(viewModel.$signInFlow) { flow in
            switch flow {
            case .success(let token):
                withAnimation {
                    appState.setToken(
                        accessToken: String(token.accessToken.split(separator: " ")[1]),
                        refreshToken: String(token.refreshToken.split(separator: " ")[1])
                    )
                    router.navigateToRoot()
                }
            case .failure:
                alertProvider.present(
                    .init(title: "로그인 실패")
                    .message("아이디 혹은 비밀번호를 다시 확인해 주세요")
                )
            default:
                break
            }
        }
        .onReceive(appleLoginViewModel.$loginFlow) { flow in
            isPresented = false
            switch flow {
            case .success(let result):
                viewModel.signIn(
                    code: result.code,
                    provider: .apple
                )
            default:
                break
            }
        }
        .onReceive(googleLoginViewModel.$loginFlow) { flow in
            switch flow {
            case .success(let result):
                if let code = result.serverAuthCode {
                    viewModel.signIn(
                        code: code,
                        provider: .google
                    )
                }
            case .failure:
                isPresented = false
            default:
                break
            }
        }
    }
    
    private func sheetContent() -> some View {
        VStack(spacing: 8) {
            SeugiButton.large("이메일로 계속하기", type: .black) {
                isPresented = false
                router.navigate(to: OnboardingDestination.emailSignIn)
            }
            .padding(.top, 20)
            AppleLoginButton(action: appleLoginViewModel.signIn)
            GoogleLoginButton(action: googleLoginViewModel.signIn)
        }
        .padding(.horizontal, 20)
        .adjustedHeightSheet(maxHeight: 230)
    }
}
