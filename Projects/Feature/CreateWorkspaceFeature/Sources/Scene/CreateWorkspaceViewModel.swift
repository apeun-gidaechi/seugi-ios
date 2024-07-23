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
import BaseFeatureInterface

final class CreateWorkspaceViewModel: BaseViewModel<CreateWorkspaceViewModel.CreateWorkspaceSubject> {
    enum CreateWorkspaceSubject {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    @Published var workspaceName = ""
    @Published var createWorkspaceFlow: IdleFlow<Bool> = .idle
    
    func createWorkspace() {
        // TODO: Add workspace image url
        sub(workspaceRepo.createWorkspace(workspaceName: workspaceName, workspaceImageUrl: "")) {
            self.createWorkspaceFlow = .fetching
        } success: { _ in
            self.createWorkspaceFlow = .success()
        } failure: { error in
            self.createWorkspaceFlow = .failure(error)
        }
    }
}
