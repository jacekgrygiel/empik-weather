//
//  Navigator.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation

enum Navigation {
    struct Name: Hashable, Equatable, RawRepresentable, ExpressibleByStringLiteral {

        typealias RawValue = String

        let rawValue: String

        init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        init(rawValue: String) {
            self.rawValue = rawValue
        }

        init(stringLiteral value: StringLiteralType) {
            self.rawValue = value
        }
    }
}
