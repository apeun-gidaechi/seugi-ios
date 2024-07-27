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
    @Published var selection = segmentedButtonRoles[0]
    @Published var workspaceCode: FetchFlow<String> = .fetching
    @Published private var studentWaitMembers: FetchFlow<[RetrieveMember]> = .fetching
    @Published private var teacherWaitMembers: FetchFlow<[RetrieveMember]> = .fetching
    var waitMembers: FetchFlow<[RetrieveMember]> {
        if selection == segmentedButtonRoles[0] {
            teacherWaitMembers
        } else {
            studentWaitMembers
        }
    }
    @Published var selectedMembers: [RetrieveMember] = []
    @Published var approveFlow: IdleFlow<Bool> = .idle
    @Published var rejectFlow: IdleFlow<Bool> = .idle
    
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
    
    func fetchWorkspaceCode(workspaceId: String) {
        sub(workspaceRepo.getWorkspaceCode(workspaceId: workspaceId)) {
            self.workspaceCode = .fetching
        } success: { response in
            self.workspaceCode = .success(response.data)
        } failure: { error in
            self.workspaceCode = .failure(error)
        }
    }
    
    func selectMember(member: RetrieveMember) {
        if selectedMembers.contains(member) {
            selectedMembers.removeAll { $0 == member}
        } else {
            selectedMembers.append(member)
        }
    }
    
    func approve(workspaceId: String) {
        sub(workspaceRepo.approveJoinWorkspace(
            workspaceId: workspaceId,
            userSet: selectedMembers.map { $0.id },
            role: selection.role
        )) {
            self.approveFlow = .fetching
        } success: { _ in
            self.approveFlow = .success()
        } failure: { error in
            self.approveFlow = .failure(error)
        }
    }
}
