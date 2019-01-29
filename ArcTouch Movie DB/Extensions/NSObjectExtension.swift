//
//  NSObjectExtension.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var className : String {
        return String(describing: self)
    }
    
    var className: String {
        return String(describing: type(of: self))
    }
    
}
