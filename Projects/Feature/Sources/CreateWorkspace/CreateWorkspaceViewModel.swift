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
import SwiftUtil

final class CreateWorkspaceViewModel: BaseViewModel<CreateWorkspaceViewModel.Effect> {
    enum Effect {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    @Published var workspaceName: String = ""
    @Published var createWorkspaceFlow: Flow<Bool> = .idle
    
    func createWorkspace(imageUrl: String) {
        // TODO: Add workspace image url
        workspaceRepo.createWorkspace(workspaceName: workspaceName, workspaceImageUrl: imageUrl)
            .map { _ in true }
            .flow(\.createWorkspaceFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
