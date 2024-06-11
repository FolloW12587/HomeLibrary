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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        if let image = book.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName: "photo.circle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(colors: [.colorMain3.opacity(0.8), .colorMain3], startPoint: .topTrailing, endPoint: .bottomLeading)
                                        )
                                        .frame(width: 150, height: 200)
                                )
                        }
                    }
                    .frame(height: 200)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        BookStateView(state: book.state)
                        
                        RatingView(rating: book.rating)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    author
                    
                    if let series = book.series {
                        NavigationLink(destination: Text(series.name)) {
                            Group {
                                if let numInSeries = book.numInSeries {
                                    Text("Book \(numInSeries) out of \(SeriesViewModel.shared.booksCount(of: series)) in ") +
                                    Text(series.name)
                                        .foregroundColor(.accent) +
                                    Text(" series")
                                } else {
                                    Text("Book of ") +
                                    Text(series.name)
                                        .foregroundColor(.accent) +
                                    Text(" series")
                                }
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        .padding(.top)
                    }
                    
                    if book.genres.count > 0 {
                        WrappingHStack(items: book.genres.sorted()) { genre in
                            NavigationLink(destination: GenreDetailsView(genre: genre)) {
                                Text(genre.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(10)
                                    .background(
                                        Capsule().fill(
                                            LinearGradient(colors: [.colorMain3.opacity(0.8), .colorMain3], startPoint: .topTrailing, endPoint: .bottomLeading)
                                        )
                                    )
                            }
                        }
                        .padding(.vertical)
                    }
                    
                    Divider()
                    
                    storage
                }
                .foregroundStyle(.colorMain)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
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
    
    var author: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: AuthorDetailsView(author: book.author)) {
                Text(book.author.representation)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.accent)
                    .padding(.top, 10)
            }
            
            if let year = book.year {
                Text("\(String(format: "%d", year))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    var storage: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let storage = book.storage {
                Text("Storage")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                NavigationLink(destination: StorageDetailsView(storage: storage)) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text(storage.name)
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundStyle(.accent)
                }
                if let shelfName = book.shelfName {
                    Text(shelfName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Divider()
            }
        }
        .foregroundStyle(.colorMain)
    }
}

#Preview {
    NavigationView {
        BookDetailsView(book: Book.examples[7])
    }
}
