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
        members.map {
            // 선생님을 선택했을 경우
            let selectedMembers = if selection == segmentedButtonRoles[0] {
                Array($0.admin.values) + Array($0.middleAdmin.values) + Array($0.teachers.values)
            } else {
                Array($0.students.values)
            }
            return selectedMembers.flatMap { $0 }
        }
    }
    
    var searchedMembers: FetchFlow<[RetrieveProfile]> {
        guard !searchText.isEmpty else {
            return selectedMembers
        }
        return selectedMembers.map {
            $0.filter { $0.member.name.contains(searchText) }
        }
    }
    
    // MARK: - Method
    func fetchMembers(workspaceId: String) {
        workspaceRepo.getMembersChart(workspaceId: workspaceId)
            .fetching {
                self.members = .fetching
            }.success {
                self.members = .success($0.data)
            }.failure { error in
                self.members = .failure(error)
            }.observe(&subscriptions)
    }
}
