//
//  Book.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import SwiftUI


struct Book {
    let authors: [Author]
    let name: String
    var rating: Int? = nil
    
    var year: Int? = nil
    
    // серия
    var series: Series? = nil
    var numInSeries: Int? = nil
    
    // где храниться
    var storage: MyStorage? = nil
    var shelfName: String? = nil
    
    // жанр
    var genre: [Genre] = []
    
    // примечание
    var note: String? = nil  // TODO: Переделать под возможность создавать кастомные примечания для книг
    
    // обложка
    var image: Image? = nil
}

extension Book {
    static let examples: [Book] = [
        Book(authors: [Author.examples[0]], name: "Преступление и наказание", year: 1866, storage: MyStorage.examples[0], shelfName: "Верхняя"),
        Book(authors: [Author.examples[0]], name: "Идиот", storage: MyStorage.examples[0], shelfName: "Верхняя"),
        Book(authors: [Author.examples[1]], name: "Война и мир", year: 1867, storage: MyStorage.examples[0], shelfName: "Верхняя"),
        Book(authors: [Author.examples[1]], name: "Анна Каренина", year: 1873, storage: MyStorage.examples[0], shelfName: "Верхняя"),
        Book(authors: [Author.examples[1]], name: "Детство", year: 1886, storage: MyStorage.examples[1], shelfName: "Нижняя"),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и философский камень", year: 1997, storage: MyStorage.examples[2]),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и Тайная комната", year: 1998, storage: MyStorage.examples[2]),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и узник Азкабана", year: 1999, storage: MyStorage.examples[2]),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и Кубок огня", year: 2000, storage: MyStorage.examples[2]),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и Орден Феникса", year: 2003, storage: MyStorage.examples[2]),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и Принц-Полукровка", year: 2005, storage: MyStorage.examples[2]),
        Book(authors: [Author.examples[2]], name: "Гарри Поттер и Дары Смерти", year: 2007, storage: MyStorage.examples[2]),
    ]
}
