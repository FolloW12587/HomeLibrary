//
//  AuthorsListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import SwiftUI

struct AuthorsListView: View {
    var authors: [Author] = AuthorsViewModel.shared.authors
    
    @State private var searchField = ""
    @State private var hideSearch = true
    
    private func filteredAuthors() -> [Author] {
        guard !searchField.isEmpty else { return authors }
        return authors.filter { author in
            author.representation.lowercased().contains(searchField.lowercased())
        }
    }
    
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ItemListView(listOfItems: authors) { author in
            HStack {
                Text(author.representation)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(height: itemHeight-1)
        } destination: { author in
            AuthorDetailsView(author: author)
        }
    }
}

#Preview {
    NavigationView {
        AuthorsListView()
    }
}
