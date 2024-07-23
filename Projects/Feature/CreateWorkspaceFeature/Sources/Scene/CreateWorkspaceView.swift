import SwiftUI
import Component
import BaseFeatureInterface

public struct CreateWorkspaceView: View {
    
    @EnvironmentObject private var router: Router
    @ObservedObject private var viewModel = CreateWorkspaceViewModel()
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                SeugiRoundedCircleImage.small(type: .icon(.imageLine))
                Image(icon: .addFill)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g600))
            }
            .button {
                
            }
            .applyAnimation()
            SeugiTextField(text: $viewModel.workspaceName)
                .padding(.horizontal, 20)
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                // TODO: Handle to create workspace
            }
        }
        .seugiTopBar("새 학교 등록")
    }
}
