//
//  ManageMemberViewModel.swift
//  SettingWorkspaceFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Domain
import DIContainer

final class WorkspaceMemberViewModel: BaseViewModel<WorkspaceMemberViewModel.Effect> {
    enum Effect {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    // MARK: - State
    @Published var selection = segmentedButtonRoles[0]
    @Published var memberSearchText = ""
    @Published var members: FetchFlow<WorkspaceMembersChart> = .fetching
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var selectedMenu: String?
    
    // MARK: - Getter
    var selectedMembers: FetchFlow<[RetrieveProfile]> {
        switch members {
        case .success(let members):
            // 선생님을 선택했을 경우
            let selectedMembers = if selection == segmentedButtonRoles[0] {
                Array(members.admin.values) + Array(members.middleAdmin.values) + Array(members.teachers.values)
            } else {
                Array(members.students.values)
            }
            print(selection)
            return .success(selectedMembers.flatMap { $0 })
        case .failure(let err):
            return .failure(err)
        case .fetching:
            return .fetching
        }
    }
    
    var searchedMembers: FetchFlow<[RetrieveProfile]> {
        guard !searchText.isEmpty else {
            return selectedMembers
        }
        switch selectedMembers {
        case .success(let members):
            let members = members.filter { $0.member.name.contains(searchText) }
            return .success(members)
        case .failure(let err):
            return .failure(err)
        case .fetching:
            return .fetching
        }
    }
    
    // MARK: - Method
    func fetchMembers(workspaceId: String) {
        sub(workspaceRepo.getMembersChart(workspaceId: workspaceId)) {
            self.members = .fetching
        } success: {
            self.members = .success($0.data)
        } failure: { error in
            self.members = .failure(error)
        }
    }
    
    
}
