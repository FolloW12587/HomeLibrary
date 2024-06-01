//
//  AuthorDetailsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 29.05.2024.
//

import SwiftUI

struct AuthorDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let author: Author
    
    private var books: [Book] {
        BooksViewModel.shared.books.filter { book in
            book.author == author
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            Text(author.representation)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            
            if !books.isEmpty {
                BooksListView(books: books, showSortings: false)
            } else {
                Text("Books of this author will be here")
            }
            
            Spacer()
            
            // TODO: Implement Delete
            Button(action: {}, label: {
                Text("Delete")
                    .foregroundStyle(.red)
            })
        }
        .foregroundStyle(.colorMain)
        .navigationBarHidden(true)
    }
    
    var title: some View {
        ZStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Text("Author details")
                .font(.title)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            Color.colorMain
                .ignoresSafeArea()
        }
    }
}

#Preview {
    AuthorDetailsView(author: Author.examples[0])
}
