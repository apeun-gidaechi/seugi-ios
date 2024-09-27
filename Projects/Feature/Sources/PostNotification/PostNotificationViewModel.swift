import Foundation
import Domain
import DIContainer

class PostNotificationViewModel: BaseViewModel<PostNotificationViewModel.Effect> {
    
    enum Effect {}
    
    @Inject private var notificationRepo: any NotificationRepo
    
    @Published var title: String = ""
    @Published var content: String = ""
    
    @Published var fetchPostNotification: IdleFlow<Bool> = .idle
    
    func createNotification(workspaceId: String) {
        notificationRepo.postNotification(.init(title: title, content: title, workspaceId: workspaceId))
            .fetching {
                self.fetchPostNotification = .fetching
            }.success { _ in
                self.fetchPostNotification = .success()
            }.failure { error in
                self.fetchPostNotification = .failure(error)
            }.observe(&subscriptions)
    }
    
    func updateNotification(notificationId: Int) {
        notificationRepo.updateNotification(
            .init(
                id: notificationId,
                title: title,
                content: content
            )
        ).fetching {
            self.fetchPostNotification = .fetching
        }.success { _ in
            self.fetchPostNotification = .success()
        }.failure { error in
            self.fetchPostNotification = .failure(error)
        }.observe(&subscriptions)
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
