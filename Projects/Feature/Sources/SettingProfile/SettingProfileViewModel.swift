import Foundation
import DIContainer
import Domain
import SwiftUtil

final class SettingProfileViewModel: BaseViewModel<SettingProfileViewModel.Effect> {
    enum Effect {}
    
    @Inject private var memberRepo: any MemberRepo
    
    @Published var editMemberFlow: Flow<Bool> = .idle
    @Published var removeMemberFlow: Flow<Bool> = .idle
    var member: RetrieveMember?
    
    func editMember(
        picture: String
    ) {
        guard let member else { return }
        memberRepo.edit(
            .init(
                picture: picture, name: member.name, birth: member.birth
            )
        )
        .map { _ in true }
        .flow(\.editMemberFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func removeMember() {
        memberRepo.remove()
            .map { _ in true }
            .flow(\.removeMemberFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
