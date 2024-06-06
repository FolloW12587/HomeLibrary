//
//  ContentView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BooksView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical.fill")
                }
            
            AuthorsView()
                .tabItem {
                    Label("Authors", systemImage: "person.2")
                }
            
            GenresView()
                .tabItem {
                    Label("Genres", systemImage: "list.star")
                }
            
            MyPlacesView()
                .tabItem {
                    Label("My places", systemImage: "house")
                }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
