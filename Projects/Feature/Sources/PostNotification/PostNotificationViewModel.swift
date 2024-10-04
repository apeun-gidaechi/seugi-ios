import Foundation
import Domain
import DIContainer
import SwiftUtil

class PostNotificationViewModel: BaseViewModel<PostNotificationViewModel.Effect> {
    
    enum Effect {}
    
    @Inject private var notificationRepo: any NotificationRepo
    
    @Published var title: String = ""
    @Published var content: String = ""
    
    @Published var fetchPostNotification: Flow<Bool> = .idle
    
    func createNotification(workspaceId: String) {
        notificationRepo.postNotification(
            .init(title: title, content: title, workspaceId: workspaceId)
        )
        .map { _ in true }
        .flow(\.fetchPostNotification, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func updateNotification(notificationId: Int) {
        notificationRepo.updateNotification(
            .init(
                id: notificationId,
                title: title,
                content: content
            )
        )
        .map { _ in true }
        .flow(\.fetchPostNotification, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
//    func removeNotification(notificationId: Int) {
//        sub(notificationRepo.removeNotification(workspaceId: <#T##String#>, id: <#T##Int#>)) {
//            <#code#>
//        } success: { <#T#> in
//            <#code#>
//        } failure: { <#APIError#> in
//            <#code#>
//        }
//    }
}
