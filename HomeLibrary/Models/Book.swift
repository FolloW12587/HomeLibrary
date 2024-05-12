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
    var rating: Int?
    
    // серия
    let series: Series?
    let numInSeries: Int?
    
    // где храниться
    let storage: Storage?
    let shelfName: String?
    
    // жанр
    let genre: Genre?
    
    // примечание
    var note: String  // У тебя в приложении какой-то странный инструмент группирования книг по примечаниям. Я не очень понял для чего
    
    // обложка
    let image: Image?
}
