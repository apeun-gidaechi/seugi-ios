import SwiftUI
import Component
import PhotosUI

public struct CreateWorkspaceView {
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var alertProvider: AlertProvider
    
    @StateObject private var fileViewModel = FileViewModel()
    @StateObject private var viewModel = CreateWorkspaceViewModel()
    
    @State private var photo: PhotosPickerItem?
    @State private var isPhotoPresent: Bool = false
    @State private var photoUrl: String?
}

extension CreateWorkspaceView: View {
    public var body: some View {
        VStack(spacing: 16) {
            Button {
                isPhotoPresent = true
            } label: {
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
            }
            .scaledButtonStyle()
            .padding(.top, 16)
            SeugiTextFieldForm(
                "학교 이름을 입력해 주세요",
                text: $viewModel.workspaceName,
                label: "학교 이름"
            )
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
        .seugiTopBar(title: "새 학교 등록")
        .photosPicker(
            isPresented: $isPhotoPresent,
            selection: $photo,
            matching: .any(of: [.images, .screenshots])
        )
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
        .onChange(of: photo) { photo in
            if let photo {
                Task {
                    await fileViewModel.uploadPhoto(photo: photo)
                }
            }
        }
        .onReceive(fileViewModel.$fileFlow) { flow in
            switch flow {
            case .success(let url):
                self.photoUrl = url
            case .failure(let error):
                debugPrint(error)
                alertProvider.present("이미지 업로드 실패")
                    .primaryButton("확인") {}
                    .message("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
            }
        }
    }
}
