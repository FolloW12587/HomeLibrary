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
                    HStack {
                        BookStateView(state: book.state)
                        
                        RatingView(rating: book.rating)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    author
                    
                    series
                    
                    storage
                    
                    genres
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
            Text("Author")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 10)
            
            NavigationLink(destination: AuthorDetailsView(author: book.author)) {
                HStack {
                    Image(systemName: "info.circle")
                    Text(book.author.representation)
                        .multilineTextAlignment(.leading)
                }
                .foregroundStyle(.accent)
            }
            
            if let year = book.year {
                Text("\(String(format: "%d", year))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Divider()
        }
    }
    
    var series: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let series = book.series {
                Text("Series")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                NavigationLink(destination: Text(series.name)) {
                    HStack {
                        HStack {
                            Image(systemName: "info.circle")
                            Text(series.name)
                                .multilineTextAlignment(.leading)
                        }
                        .foregroundStyle(.accent)
                    }
                    
                    if let numInSeries = book.numInSeries {
                        Text("\(numInSeries) out of \(SeriesViewModel.shared.booksCount(of: series))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                
                Divider()
            }
        }
        .foregroundStyle(.colorMain)
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
                        Group {
                            if let image = storage.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else {
                                Image(systemName: "photo.circle.fill")
                                    .resizable()
                                    .opacity(0.7)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.colorMain3)
                            }
                        }
                        .frame(width: 44)
                        .clipShape(Circle())
                        
                        Text(storage.name)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.headline)
                            .foregroundStyle(.accent)
                    }
                    .frame(height: 54)
                }
                
                Divider()
            }
        }
        .foregroundStyle(.colorMain)
    }
    
    var genres: some View {
        VStack(alignment: .leading, spacing: 10) {
            if book.genres.count > 0 {
                Text("Genres")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                ForEach(book.genres.sorted()) { genre in
                    NavigationLink(destination: GenreDetailsView(genre: genre)) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text(genre.name)
                                .multilineTextAlignment(.leading)
                        }
                        .foregroundStyle(.accent)
                    }
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
