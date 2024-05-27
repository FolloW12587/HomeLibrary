//
//  Author.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import Foundation


struct Author: Identifiable {
    let id: UUID
    
    let firstName: String
    let secondName: String
    let surname: String
}

extension Author: StringRepresentable {
    var representation: String {
        "\(secondName.capitalized) \(firstName.capitalized) \(surname.capitalized)"
    }
}

extension Author: Hashable, Comparable {
    static func < (lhs: Author, rhs: Author) -> Bool {
        lhs.representation < rhs.representation
    }
}
