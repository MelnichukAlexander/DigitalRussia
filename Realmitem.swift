//
//  Realmitem.swift
//  DigitalAdviser
//
//  Created by Александр on 28.07.2019.
//  Copyright © 2019 Alexander Melnichuk. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Airport: Object, Decodable {
    @objc dynamic var id: String = ""
    @objc dynamic var reqtype: String = ""
    @objc dynamic var clarify: String = ""
    @objc dynamic var tagmark: String = ""
    @objc dynamic var info: String = ""

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum AirportCodingKeys: String, CodingKey {
        case id
        case reqtype
        case clarify
        case tagmark
        case info
    }
    
    convenience init(id: String, reqtype: String, clarify: String, tagmark: String, info: String) {
        self.init()
        self.id = id
        self.reqtype = reqtype
        self.clarify = clarify
        self.tagmark = tagmark
        self.info = info
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AirportCodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let reqtype = try container.decode(String.self, forKey: .reqtype)
        let clarify = try container.decode(String.self, forKey: .clarify)
        let tagmark = try container.decode(String.self, forKey: .tagmark)
        let info = try container.decode(String.self, forKey: .info)
        self.init(id: id, reqtype: reqtype, clarify: clarify, tagmark: tagmark, info: info)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
}

