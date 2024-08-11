//
//  ManageMemberViewModel.swift
//  SettingWorkspaceFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import Domain
import DIContainer

final class WorkspaceMemberViewModel: BaseViewModel<WorkspaceMemberViewModel.Subject> {
    enum Subject {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    var selection = segmentedButtonRoles[0]
    @Published var memberSearchText = ""
    @Published var members: FetchFlow<WorkspaceMembersChart> = .fetching
    @Published var searchText = ""
    @Published var isSearching = false
    var menus: [String] {
        let keys = selection == segmentedButtonRoles[0] ? members.data?.teachers.keys : members.data?.students.keys
        return keys.map { Array($0) } ?? []
    }
    @Published var selectedMenu: String?
    var selectedMembers: [RetrieveProfile] {
        let membersDict = selection == segmentedButtonRoles[0] ? members.data?.teachers : members.data?.students
        let filteredMembers = membersDict?.filter { key, _ in
            guard selectedMenu != nil else {
                return true
            }
            return menus.contains(key)
        }.values
        return filteredMembers.map { $0.flatMap { $0 } } ?? []
    }
    var searchtedMembers: [RetrieveProfile] {
        guard !searchText.isEmpty else {
            return selectedMembers
        }
        return selectedMembers.filter { member in
            member.member.name.contains(searchText)
        }
    }
    
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
