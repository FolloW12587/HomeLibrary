//
//  Series.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import Foundation


struct Series: Identifiable {
    let id = UUID()
    let author: Author
    let name: String
}

extension Series: Comparable, Hashable {
    static func < (lhs: Series, rhs: Series) -> Bool {
        lhs.name < rhs.name
    }
}

extension Series: StringRepresentable {
    var representation: String {
        name
    }
}

extension Series {
    static let examples = [
        Series(author: Author.examples.last!, name: "Гарри Поттер")
    ]
}
