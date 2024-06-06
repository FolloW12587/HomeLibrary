//
//  GenreDetailsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 06.06.2024.
//

import SwiftUI

struct GenreDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let genre: Genre
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            BooksListView(books: BooksViewModel.shared.books.filter({ $0.genre.contains(genre) }))

            // TODO: Implement Delete
            Button(action: {}, label: {
                Text("Delete")
                    .foregroundStyle(.red)
            })
        }
        .navigationBarHidden(true)
    }

    var title: some View {
        ZStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(genre.name)
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
    NavigationView {
        GenreDetailsView(genre: Genre.examples[38])
    }
}
