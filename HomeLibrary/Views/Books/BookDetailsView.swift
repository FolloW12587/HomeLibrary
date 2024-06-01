//
//  BookDetailsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 02.06.2024.
//

import SwiftUI

struct BookDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    let book: Book
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 10) {
                Text(book.name)
                    .font(.title.bold())
                

                NavigationLink(destination: AuthorDetailsView(author: book.author)) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text(book.author.representation)
                    }
                    .foregroundStyle(.accent)
                }
            }
            .foregroundStyle(.colorMain)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            
            Spacer()
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
            
            Text(book.name)
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
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
        BookDetailsView(book: Book.examples[0])
    }
}