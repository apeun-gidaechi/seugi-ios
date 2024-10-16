import Foundation
import DIContainer
import Domain
import SwiftUtil
import Combine

final class SettingProfileViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var memberRepo: MemberRepo
    
    @Published var editMemberFlow: Flow<BaseVoid> = .idle
    @Published var removeMemberFlow: Flow<BaseVoid> = .idle
    @Published var updateMember: RetrieveMember?
    
    func editMember() {
        guard let updateMember else { return }
        memberRepo.edit(
            .init(
                picture: updateMember.picture,
                name: updateMember.name,
                birth: updateMember.birth
            )
        )
        .flow(\.editMemberFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func removeMember() {
        memberRepo.remove()
            .flow(\.removeMemberFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
