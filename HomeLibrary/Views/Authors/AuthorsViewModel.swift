//
//  AuthorsViewModel.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import Foundation


class AuthorsViewModel: ObservableObject {
    static let shared = AuthorsViewModel()
    
    @Published var authors: [Author] = Author.examples
    
    private init() {}
    
    func newAuthor(firstName: String, secondName: String, surname: String) {
        authors.append(Author(firstName: firstName, secondName: secondName, surname: surname))
    }
}
