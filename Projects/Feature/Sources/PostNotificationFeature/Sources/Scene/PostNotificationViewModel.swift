import Foundation
import Domain
import DIContainer

class PostNotificationViewModel: BaseViewModel<PostNotificationViewModel.PostNotificationSubject> {
    
    enum PostNotificationSubject {}
    
    @Inject private var notificationRepo: any NotificationRepo
    
    @Published var title = ""
    @Published var content = ""
    
    @Published var fetchPostNotification: IdleFlow<Bool> = .idle
    
    func createNotification(workspaceId: String) {
        sub(notificationRepo.postNotification(title: title, content: title, workspaceId: workspaceId)) {
            self.fetchPostNotification = .fetching
        } success: { _ in
            self.fetchPostNotification = .success()
        } failure: { error in
            self.fetchPostNotification = .failure(error)
        }
    }
    
    func updateNotification(notificationId: Int) {
        sub(notificationRepo.updateNotification(
            id: notificationId,
            title: title,
            content: content
        )) {
            self.fetchPostNotification = .fetching
        } success: { _ in
            self.fetchPostNotification = .success()
        } failure: { error in
            self.fetchPostNotification = .failure(error)
        }
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
