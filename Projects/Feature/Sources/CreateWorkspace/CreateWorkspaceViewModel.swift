//
//  CreateWorkspaceViewModel.swift
//  CreateWorkspaceFeature
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Domain
import DIContainer

final class CreateWorkspaceViewModel: BaseViewModel<CreateWorkspaceViewModel.Effect> {
    enum Effect {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    @Published var workspaceName: String = ""
    @Published var createWorkspaceFlow: IdleFlow<Bool> = .idle
    
    func createWorkspace(imageUrl: String) {
        // TODO: Add workspace image url
        workspaceRepo.createWorkspace(workspaceName: workspaceName, workspaceImageUrl: imageUrl)
            .fetching {
                self.createWorkspaceFlow = .fetching
            }.success { _ in
                self.createWorkspaceFlow = .success()
            }.failure { error in
                self.createWorkspaceFlow = .failure(error)
            }.observe(&subscriptions)
    }
}
