//
//  Localizable.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, tableName: nil, comment: self)
    }
}
