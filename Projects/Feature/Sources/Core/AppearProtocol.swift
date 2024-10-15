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
    func fetchAllData(workspaceId: String, userId: Int)
}

// Only view can be used.
extension OnAppearProtocol {
    func onAppear(workspaceId: String) {
        if isFirstOnAppear {
            fetchAllData(workspaceId: workspaceId)
            self.isFirstOnAppear = false
        }
    }
    
    func onAppear(workspaceId: String, userId: Int) {
        if isFirstOnAppear {
            fetchAllData(workspaceId: workspaceId, userId: userId)
            self.isFirstOnAppear = false
        }
    }
    
    func refresh(workspaceId: String) {
        fetchAllData(workspaceId: workspaceId)
    }
    
    func refresh(workspaceId: String, userId: Int) {
        fetchAllData(workspaceId: workspaceId, userId: userId)
    }
    
    // Optional override method
    func fetchAllData(workspaceId: String) {}
    func fetchAllData(workspaceId: String, userId: Int) {}
}
