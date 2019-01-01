//
//  Category.swift
//  Todoey
//
//  Created by Ravindra Kumar on 12/28/18.
//  Copyright © 2018 Ravindra Kumar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
     @objc dynamic var color: String = ""
    let items = List<Item>()
}
