import SwiftUtil
import Domain

struct BaseRes<Data: Decodable & EntityMappable>: Decodable, EntityMappable {
    let status: Int
    let success: Bool
    let state: String
    let message: String
    let data: Data
    
    func toEntity() -> Base<Data.Entity> {
        Base(
            status: status,
            success: success,
            state: state,
            message: message,
            data: data.toEntity()
        )
    }
}

struct BaseVoidRes: Decodable {
    let status: Int
    let success: Bool
    let state: String
    let message: String
    
    func toEntity() -> BaseVoid {
        BaseVoid(
            status: status,
            success: success,
            state: state,
            message: message
        )
    }
}
