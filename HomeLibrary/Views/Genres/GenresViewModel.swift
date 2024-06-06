//
//  GenresViewModel.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 06.06.2024.
//

import Foundation

class GenresViewModel: ObservableObject {
    static let shared = GenresViewModel()
    
    @Published var genres: [Genre] = Genre.examples
    
    private init() {}
}
