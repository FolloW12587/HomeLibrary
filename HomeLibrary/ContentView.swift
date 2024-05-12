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
            Text("Books")
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
            Text("Authors")
                .tabItem {
                    Label("Authors", systemImage: "person.2")
                }
            
            Text("Places")
                .tabItem {
                    Label("My places", systemImage: "house")
                }
        }
    }
}

#Preview {
    ContentView()
}
