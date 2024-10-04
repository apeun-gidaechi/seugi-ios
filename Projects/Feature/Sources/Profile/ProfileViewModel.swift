import Foundation
import DIContainer
import Domain
import SwiftUtil
import Combine

final class ProfileViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Properties
    @Inject private var profileRepo: any ProfileRepo
    
    @Published var updateProfile: RetrieveProfile?
    @Published var updateProfileFlow: Flow<Bool> = .fetching
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
        .map { _ in true }
        .flow(\.updateProfileFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
