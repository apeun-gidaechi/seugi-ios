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
    
    func editMember(
        picture: String,
        member: RetrieveMember
    ) {
        memberRepo.edit(
            .init(
                picture: picture,
                name: member.name,
                birth: member.birth
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
