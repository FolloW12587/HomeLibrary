//
//  Author.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import Foundation


struct Author: Identifiable {
    let id: UUID = UUID()
    
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

extension Author {
    static let examples: [Author] = [
        Author(firstName: "Федор", secondName: "Достоевский", surname: "Михайлович"),
        Author(firstName: "Лев", secondName: "Толстой", surname: "Николаевич"),
        Author(firstName: "Джоан", secondName: "Роулинг", surname: "Кэтлин"),
    ]
}
