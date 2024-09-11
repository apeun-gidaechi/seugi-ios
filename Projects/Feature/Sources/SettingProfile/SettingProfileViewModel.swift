//
//  SettingProfileViewModel.swift
//  SettingProfileFeature
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import DIContainer
import Domain

final class SettingProfileViewModel: BaseViewModel<SettingProfileViewModel.Effect> {
    enum Effect {}
    
    @Inject private var memberRepo: any MemberRepo
    
    @Published var editMemberFlow: IdleFlow<Bool> = .idle
    var member: RetrieveMember?
    
    func editMember(
        picture: String
    ) {
        guard let member else {
            return
        }
        sub(memberRepo.edit(
            .init(
                picture: picture, name: member.name, birth: member.birth
            )
        )) {
            self.editMemberFlow = .fetching
        } success: { _ in
            self.editMemberFlow = .success()
        } failure: { error in
            self.editMemberFlow = .failure(error)
        }
    }
}
