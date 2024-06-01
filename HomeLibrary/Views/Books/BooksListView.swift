//
//  BooksListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 01.06.2024.
//

import SwiftUI

struct BooksListView: View {
    let books: [Book]
    var showSortings = true
    
    var body: some View {
        ItemListView(listOfItems: books, listOfSortings: showSortings ? Book.sortings : nil) { book in
            HStack {
                Group {
                    if let image = book.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        ZStack {
                            Color.colorMain4
                            
                            Image(systemName: "photo")
                                .foregroundStyle(.white)
                        }
                    }
                }
                .frame(width: 60, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(book.name)
                        .font(.headline)
                        .foregroundStyle(.colorMain)
                        .lineSpacing(-5)
                    
                    HStack {
                        Text(book.author.representation)
                        
                        if let year = book.year {
                            Text("(\(String(format: "%d", year)))")
                        }
                    }
                    .font(.subheadline)
                    .foregroundStyle(.colorMain.opacity(0.7))
                    
                    Spacer(minLength: 0)
                    
                    RatingView(rating: book.rating)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.vertical, 3)
                .multilineTextAlignment(.leading)
                
                Image(systemName: "chevron.right")
                    .font(.headline)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(height: 100)
        } destination: { book in
            BookDetailsView(book: book)
        }
    }
}

#Preview {
    BooksListView(books: Book.examples)
}
