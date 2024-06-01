//
//  BooksViewModel.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 01.06.2024.
//

import Foundation

class BooksViewModel: ObservableObject {
    static let shared = BooksViewModel()
    
    @Published var books = Book.examples
    
    private init() {}
}
