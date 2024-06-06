//
//  GenresListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 06.06.2024.
//

import SwiftUI

struct GenresListView: View {
    let genres: [Genre]
    
    var body: some View {
        ItemListView(listOfItems: genres) { genre in
            HStack {
                Text(genre.name)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(height: 54)
        } destination: { genre in
            Text(genre.name)
        }
    }
}

#Preview {
    GenresListView(genres: Genre.examples)
}
