//
//  RegexPattern.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation

struct RegexPattern {
    static let cityRegex = "^[A-Za-ząćęłńóśźżĄĆĘŁŃÓŚŹŻ ]+$"
}

enum RegexError: Error {
    case invalid
}
