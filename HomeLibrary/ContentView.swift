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
                    Label("Books", systemImage: "book")
                }
            
            AuthorsView()
                .tabItem {
                    Label("Authors", systemImage: "person.2")
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
