import SwiftUI

struct UpdateNotificationCoordinator: View {
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        UpdateNotificationView(id: id)
    }
}
