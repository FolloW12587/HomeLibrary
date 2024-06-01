//
//  BooksView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 01.06.2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var viewModel = BooksViewModel.shared
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            BooksListView(books: viewModel.books)

        }
    }
    
    var title: some View {
        ZStack {
            Text("Books")
                .font(.title)
                .foregroundStyle(.white)
            
            NavigationLink(destination: Text("")) {
                Image(systemName: "plus")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
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
        BooksView()
    }
}
