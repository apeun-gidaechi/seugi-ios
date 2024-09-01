//
//  LocalRetrieveMember.swift
//  Local
//
//  Created by hhhello0507 on 9/1/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

final class LocalRetrieveMember: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var email: String
    @Persisted var birth: String
    @Persisted var name: String
    @Persisted var picture: String
    
    convenience init(id: Int, email: String, birth: String, name: String, picture: String) {
        self.init()
        self.id = id
        self.email = email
        self.birth = birth
        self.name = name
        self.picture = picture
    }
    
    static func of(member: RetrieveMember) -> LocalRetrieveMember {
        return LocalRetrieveMember(
            id: member.id,
            email: member.email,
            birth: member.birth,
            name: member.name,
            picture: member.picture
        )
    }
    
    func toRetrieveMember() -> RetrieveMember {
        RetrieveMember(
            id: self.id,
            email: self.email,
            birth: self.birth,
            name: self.name,
            picture: self.picture
        )
    }
}
