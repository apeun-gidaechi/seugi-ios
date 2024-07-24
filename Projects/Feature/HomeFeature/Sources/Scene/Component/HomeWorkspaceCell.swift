//
//  HomeWorkspaceCell.swift
//  HomeFeature
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component
import Domain

struct HomeWorkspaceCell: View {
    
    private let workspace: Workspace
    private let workspaceRole: WorkspaceRole
    private let settingAction: () -> Void
    
    init(
        workspace: Workspace,
        workspaceRole: WorkspaceRole,
        settingAction: @escaping () -> Void
    ) {
        self.workspace = workspace
        self.workspaceRole = workspaceRole
        self.settingAction = settingAction
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Text(workspace.workspaceName)
                .font(.subtitle(.s2))
                .seugiColor(.sub(.black))
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
            switch workspaceRole {
            case .middleAdmin, .admin:
                Image(icon: .settingFill)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g500))
                    .button {
                        settingAction()
                    }
            default: EmptyView()
            }
            Image(icon: .expandRightLine)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .seugiColor(.gray(.g500))
        }
        .padding(16)
        .seugiBackground(.primary(.p050))
        .cornerRadius(8)
    }
}
