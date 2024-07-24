//
//  InvitationMemberViewModel.swift
//  SettingWorkspaceFeature
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import DIContainer
import Domain

final class InvitationMemberViewModel: BaseViewModel<InvitationMemberViewModel.InvitationMemberSubject> {
    enum InvitationMemberSubject {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    // MARK: - Properties
    @Published private var studentWaitMembers: FetchFlow<[Int]> = .fetching
    @Published private var teacherWaitMembers: FetchFlow<[Int]> = .fetching
    @Published var selection = segmentedButtonRoles[0]
    
    // MARK: - Method
    func fetchWaitMembers(workspaceId: String) {
        sub(workspaceRepo.getWaitList(workspaceId: workspaceId, workspaceRole: .student)) {
            self.studentWaitMembers = .fetching
        } success: { response in
            self.studentWaitMembers = .success(response.data)
        } failure: { error in
            self.studentWaitMembers = .failure(error)
        }
        sub(workspaceRepo.getWaitList(workspaceId: workspaceId, workspaceRole: .teacher)) {
            self.teacherWaitMembers = .fetching
        } success: { response in
            self.teacherWaitMembers = .success(response.data)
        } failure: { error in
            self.teacherWaitMembers = .failure(error)
        }
    }
}
