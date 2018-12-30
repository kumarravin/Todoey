//
//  Item.swift
//  Todoey
//
//  Created by Ravindra Kumar on 12/28/18.
//  Copyright © 2018 Ravindra Kumar. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
     @objc dynamic var title : String = ""
     @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
     var parentCategoty = LinkingObjects(fromType: Category.self, property: "items")
}
