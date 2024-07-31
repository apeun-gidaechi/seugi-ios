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

final class ManageMemberViewModel: BaseViewModel<ManageMemberViewModel.ManageMemberViewSubject> {
    enum ManageMemberViewSubject {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    @Published var memberSearchText = ""
    @Published var members: FetchFlow<[RetrieveProfile]> = .fetching
    @Published var searchText = ""
    var searchedMembers: [RetrieveProfile] {
        if searchText.isEmpty {
            members.data ?? []
        } else {
            members.data?.filter { member in
                member.member.name.contains(searchText)
            } ?? []
        }
    }
    
    func fetchMembers(workspaceId: String) {
        sub(workspaceRepo.getMembers(workspaceId: workspaceId)) {
            self.members = .fetching
        } success: {
            self.members = .success($0.data)
        } failure: { error in
            self.members = .failure(error)
        }
    }
}
