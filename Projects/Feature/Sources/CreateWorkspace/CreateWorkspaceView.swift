import SwiftUI
import Component
import PhotosUI

public struct CreateWorkspaceView: View {
    
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var fileManager: FileManager
    @ObservedObject private var viewModel = CreateWorkspaceViewModel()
    
    @State private var photo: PhotosPickerItem?
    @State private var isPhotoPresent: Bool = false
    @State private var photoUrl: String?
    
    public var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                SeugiRoundedCircleAsyncImage.small(url: photoUrl)
                if photoUrl == nil {
                    Image(icon: .addFill)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .seugiColor(.gray(.g600))
                }
            }
            .button {
                isPhotoPresent = true
            }
            .applyAnimation()
            .padding(.top, 16)
            SeugiTextFieldForm("학교 이름을 입력해 주세요", text: $viewModel.workspaceName, label: "학교 이름")

            Spacer()
            SeugiButton.large(
                "계속하기",
                type: .primary,
                isLoading: viewModel.createWorkspaceFlow.is(.fetching)
            ) {
                viewModel.createWorkspace(imageUrl: photoUrl ?? "")
            }
            .disabled(viewModel.workspaceName.isEmpty)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("새 학교 등록")
        .onReceive(viewModel.$createWorkspaceFlow) { flow in
            switch flow {
            case .success:
                alertProvider.present("학교 등록 성공")
                    .primaryButton("닫기") {
                        appState.fetchWorkspaces()
                        router.navigateToRoot()
                    }
                    .show()
            case .failure:
                alertProvider.present("학교 등록 실패")
                    .primaryButton("확인") {}
                    .message("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
            }
        }
        .photosPicker(
            isPresented: $isPhotoPresent,
            selection: $photo,
            matching: .any(of: [.images, .screenshots])
        )
        .onChange(of: photo) { photo in
            if let photo {
                fileManager.uploadPhoto(photo: photo) { url in
                    self.photoUrl = url
                } failure: { _ in
                    alertProvider.present("이미지 업로드 실패")
                        .primaryButton("확인") {}
                        .message("잠시 후 다시 시도해 주세요")
                        .show()
                }
            }
        }
    }
}
