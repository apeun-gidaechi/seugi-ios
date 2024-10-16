//  Author: hhhello0507
//  Created: 10/7/24


import Foundation

// AnyObject: Only viewmodel are allowed to confirm to the protocol
protocol OnAppearProtocol: AnyObject {
    // Set default to true.
    // Only viewmodel can be used.
    var isFirstOnAppear: Bool { get set }
    
    // Only viewmodel can be used.
    func fetchAllData(workspaceId: String)
}

// Only view can be used.
extension OnAppearProtocol {
    func onCreate(workspaceId: String) {
        if isFirstOnAppear {
            fetchAllData(workspaceId: workspaceId)
            self.isFirstOnAppear = false
        }
    }
    
    func onAppear(workspaceId: String) {
        fetchAllData(workspaceId: workspaceId)
    }
}
