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
    
    func createWorkspace() {
//        sub(workspaceRepo.) {
//            <#code#>
//        } success: { <#T#> in
//            <#code#>
//        } failure: { <#APIError#> in
//            <#code#>
//        }

    }
}
