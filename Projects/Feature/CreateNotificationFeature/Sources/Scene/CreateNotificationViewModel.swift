import Foundation
import Domain
import BaseFeatureInterface
import DIContainer

class CreateNotificationViewModel: BaseViewModel<CreateNotificationViewModel.CreateNotificationSubject> {
    
    enum CreateNotificationSubject {}
    
    @Inject private var notificationRepo: any NotificationRepo
    
    @Published var title = ""
    @Published var content = ""
    
    @Published var fetchCreateNotification: IdleFlow<Bool> = .idle
    
    func createNotification(workspaceId: String) {
        sub(notificationRepo.createNotification(title: title, content: title, workspaceId: workspaceId)) {
            self.fetchCreateNotification = .fetching
        } success: { _ in
            self.fetchCreateNotification = .success()
        } failure: { error in
            self.fetchCreateNotification = .failure(error)
        }
    }
}
