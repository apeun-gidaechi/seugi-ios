//
//  ProfileViewModel.swift
//  ProfileFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import DIContainer
import Domain

final class ProfileViewModel: BaseViewModel<ProfileViewModel.Effect> {
    enum Effect {}
    
    // MARK: - Properties
    @Inject private var profileRepo: any ProfileRepo
    
    @Published var updateProfile: RetrieveProfile?
    @Published var updateProfileFlow: IdleFlow<Bool> = .fetching
    @Published var selectedProfleInfo: WritableKeyPath<RetrieveProfile, String>?
    
    var selectedProfleInfolabel: String {
        selectedProfleInfo?.label ?? ""
    }
    
    var updateProfileContent: String? {
        get {
            guard let selectedProfleInfo,
                    let updateProfile else {
                return nil
            }
            return updateProfile[keyPath: selectedProfleInfo]
        }
        set {
            guard let selectedProfleInfo,
                  var updateProfile else {
                return
            }
            updateProfile[keyPath: selectedProfleInfo] = newValue ?? ""
            self.updateProfile = updateProfile
        }
    }
    
    // MARK: - Method
    func updateProfile(
        workspaceId: String
    ) {
        guard let updateProfile else {
            return
        }
        profileRepo.patchProfile(
            workspaceId: workspaceId,
            .init(
                status: updateProfile.status,
                nick: updateProfile.nick,
                spot: updateProfile.spot,
                belong: updateProfile.belong,
                phone: updateProfile.phone,
                wire: updateProfile.wire,
                location: updateProfile.location
            )
        ).fetching {
            self.updateProfileFlow = .fetching
        }.success { _ in
            self.updateProfileFlow = .success()
        }.failure { error in
            self.updateProfileFlow = .failure(error)
        }.observe(&subscriptions)
    }
}
