//
//  DateFormatterExtension.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatReadableDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
}
