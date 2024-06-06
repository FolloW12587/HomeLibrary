//
//  Genre.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import Foundation

/// Жанр книги
struct Genre: Identifiable {
    let id = UUID()
    let name: String
}

extension Genre: Comparable, Hashable {
    static func < (lhs: Genre, rhs: Genre) -> Bool {
        lhs.name < rhs.name
    }
}

extension Genre: StringRepresentable {
    var representation: String {
        name
    }
}


extension Genre {
    static let examples = [
        Genre(name: "Фэнтези"),
        Genre(name: "Научная фантастика"),
        Genre(name: "Детектив"),
        Genre(name: "Триллер"),
        Genre(name: "Ужасы"),
        Genre(name: "Роман"),
        Genre(name: "Исторический роман"),
        Genre(name: "Биография"),
        Genre(name: "Автобиография"),
        Genre(name: "Путешествия"),
        Genre(name: "Приключения"),
        Genre(name: "Классическая литература"),
        Genre(name: "Юмор"),
        Genre(name: "Эссе"),
        Genre(name: "Психология"),
        Genre(name: "Саморазвитие"),
        Genre(name: "Мистика"),
        Genre(name: "Поэзия"),
        Genre(name: "Философия"),
        Genre(name: "Научно-популярная литература"),
        Genre(name: "Молодежная литература"),
        Genre(name: "Драма"),
        Genre(name: "Любовный роман"),
        Genre(name: "Детская литература"),
        Genre(name: "Сказки"),
        Genre(name: "Фольклор"),
        Genre(name: "Кулинария"),
        Genre(name: "Публицистика"),
        Genre(name: "Литература о природе"),
        Genre(name: "Спорт"),
        Genre(name: "Экономика"),
        Genre(name: "Бизнес-литература"),
        Genre(name: "Политика"),
        Genre(name: "Военная литература"),
        Genre(name: "Пьесы"),
        Genre(name: "Религия и духовность"),
        Genre(name: "Эротика"),
        Genre(name: "Дистопия"),
        Genre(name: "Урбан-фэнтези"),
        Genre(name: "Киберпанк")
    ]
}
