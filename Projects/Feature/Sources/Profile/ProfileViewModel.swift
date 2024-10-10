import Foundation
import DIContainer
import Domain
import SwiftUtil
import Combine

final class ProfileViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var profileRepo: ProfileRepo
    
    @Published var updateProfile: RetrieveProfile?
    @Published var updateProfileFlow: Flow<BaseVoid> = .fetching
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
        )
        .flow(\.updateProfileFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
