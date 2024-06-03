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
        NavigationView {
            VStack(spacing: 0) {
                title
                
                BooksListView(books: viewModel.books)
                
            }
            .navigationBarHidden(true)
        }
    }
    
    var title: some View {
        ZStack {
            Text("Books")
                .font(.title)
                .foregroundStyle(.white)
            
            NavigationLink(destination: Text("New book")) {
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
