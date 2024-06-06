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
    
    var state: BookState = .notRead
    
    var rating: Int? = nil
    
    // серия
    var series: Series? = nil
    var numInSeries: Int? = nil
    
    // где храниться
    var storage: MyStorage? = nil
    var shelfName: String? = nil
    
    // жанр
    var genres: Set<Genre> = []
    
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

extension Book {
    enum BookState: CaseIterable {
        case notRead
        case read
        case reading
        case postponed
        case dropped
        
        var color: Color {
            switch self {
            case .notRead:
                .orange
            case .read:
                .green
            case .reading:
                .yellow
            case .postponed:
                .orange
            case .dropped:
                .black
            }
        }
        
        var localized: String {
            switch self {
            case .notRead:
                String(localized: "Not read")
            case .read:
                String(localized: "Read")
            case .reading:
                String(localized: "Reading")
            case .postponed:
                String(localized: "Postponed")
            case .dropped:
                String(localized: "Dropped from reading")
            }
        }
    }
}

extension Book: StringRepresentable {
    var representation: String {
        name
    }
}

extension Book {
    static let examples: [Book] = [
        Book(author: Author.examples[0], name: "Преступление и наказание", year: 1866, storage: MyStorage.examples[0], shelfName: "Верхняя", genres: Set([6, 11, 14, 21].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[0], name: "Идиот", storage: MyStorage.examples[0], shelfName: "Верхняя", genres: Set([6, 11, 14, 21].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[1], name: "Война и мир", year: 1867, storage: MyStorage.examples[0], shelfName: "Верхняя", genres: Set([6, 11, 33, 21].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[1], name: "Анна Каренина", year: 1873, rating: 4, storage: MyStorage.examples[0], shelfName: "Верхняя", genres: Set([6, 11, 21, 22].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[1], name: "Детство", year: 1886, storage: MyStorage.examples[1], shelfName: "Нижняя"),
        Book(author: Author.examples[2], name: "Гарри Поттер и философский камень", year: 1997, series: Series.examples[0], numInSeries: 1, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] })), image: Image("harry_potter_stone")),
        Book(author: Author.examples[2], name: "Гарри Поттер и Тайная комната", year: 1998, series: Series.examples[0], numInSeries: 2, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и узник Азкабана", year: 1999, series: Series.examples[0], numInSeries: 3, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Кубок огня", year: 2000, series: Series.examples[0], numInSeries: 4, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Орден Феникса", year: 2003, series: Series.examples[0], numInSeries: 5, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Принц-Полукровка", year: 2005, series: Series.examples[0], numInSeries: 6, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
        Book(author: Author.examples[2], name: "Гарри Поттер и Дары Смерти", year: 2007, series: Series.examples[0], numInSeries: 7, storage: MyStorage.examples[2], genres: Set([0, 20, 10, 38].map({ Genre.examples[$0] }))),
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
