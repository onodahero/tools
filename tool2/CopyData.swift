//
//  CopyData.swift
//  tool2
//
//  Created by 斧田洋人 on 2018/06/21.
//  Copyright © 2018年 斧田洋人. All rights reserved.
//

import UIKit
import RealmSwift

class CopyData: Object {
    
    var lastID = 0
    
    @objc dynamic var id = -1
    
    @objc dynamic var text = ""
    @objc dynamic var tag = 0

}
