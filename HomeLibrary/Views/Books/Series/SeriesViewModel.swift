//
//  SeriesViewModel.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 06.06.2024.
//

import Foundation


class SeriesViewModel: ObservableObject {
    static let shared = SeriesViewModel()
    
    private init() {}
    
    @Published var series: [Series] = Series.examples
    
    func booksCount(of series: Series) -> Int {
        BooksViewModel.shared.books.reduce(0) { partialResult, book in
            book.series == series ? partialResult + 1 : partialResult
        }
    }
}
