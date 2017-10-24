//
//  ToDoItem.swift
//  ClearClone
//
//  Created by Michael Pettiford on 10/24/17.
//  Copyright © 2017 Michael Pettiford. All rights reserved.
//

import UIKit

class ToDoItem : NSObject {
    var text : String
    var completed : Bool
    init(text: String) {
        self.text = text
        self.completed = false
    }
}
