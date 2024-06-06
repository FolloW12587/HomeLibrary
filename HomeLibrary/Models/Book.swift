//
//  Book.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import SwiftUI


struct Book: Identifiable {
    let id: UUID = .init()
    let author: Author
    let name: String
    var year: Int? = nil
    
    var rating: Int? = nil
    
    // серия
    var series: Series? = nil
    var numInSeries: Int? = nil
    
    // где храниться
    var storage: MyStorage? = nil
    var shelfName: String? = nil
    
    // жанр
    var genre: Set<Genre> = []
    
    // примечание
    var note: String? = nil  // TODO: Переделать под возможность создавать кастомные примечания для книг
    
    // обложка
    var image: Image? = nil
}

extension Book: Hashable, Comparable {
    static func < (lhs: Book, rhs: Book) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(author)
        hasher.combine(name)
    }
}

extension Book: StringRepresentable {
    var representation: String {
        name
    }
}

extension Book {
    static let examples: [Book] = [
        Book(author: Author.examples[0], name: "Преступление и наказание", year: 1866, storage: MyStorage.examples[0], shelfName: "Верхняя", genre: Set([6, 11, 14, 21].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[0], name: "Идиот", storage: MyStorage.examples[0], shelfName: "Верхняя", genre: Set([6, 11, 14, 21].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[1], name: "Война и мир", year: 1867, storage: MyStorage.examples[0], shelfName: "Верхняя", genre: Set([6, 11, 33, 21].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[1], name: "Анна Каренина", year: 1873, rating: 4, storage: MyStorage.examples[0], shelfName: "Верхняя", genre: Set([6, 11, 21, 22].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[1], name: "Детство", year: 1886, storage: MyStorage.examples[1], shelfName: "Нижняя"),
        Book(author: Author.examples[2], name: "Гарри Поттер и философский камень", year: 1997, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] })), image: Image("harry_potter_stone")),
        Book(author: Author.examples[2], name: "Гарри Поттер и Тайная комната", year: 1998, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и узник Азкабана", year: 1999, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Кубок огня", year: 2000, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Орден Феникса", year: 2003, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Принц-Полукровка", year: 2005, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Дары Смерти", year: 2007, storage: MyStorage.examples[2], genre: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
    ]
}

extension Book {
    // MARK: Sortings
    static let sortings: [Sorting<Self>] = [
        Sorting<Self>(by: "Name", closure: { $0.name < $1.name }),
        Sorting<Self>(by: "Author", closure: { $0.author.representation < $1.author.representation }),
        Sorting<Self>(by: "Year", closure: { $0.year ?? 3000 < $1.year ?? 3000 }),
        Sorting<Self>(by: "Rating", closure: { $0.rating ?? 0 < $1.rating ?? 0 }),
    ]
}
