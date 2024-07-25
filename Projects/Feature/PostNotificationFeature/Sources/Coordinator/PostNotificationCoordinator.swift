import SwiftUI
import PostNotificationFeatureInterface

struct PostNotificationCoordinator: View {
    
    private let type: PostNotificationType
    
    init(
        type: PostNotificationType
    ) {
        self.type = type
    }
    
    var body: some View {
        PostNotificationView(
            type: type
        )
    }
}
