//
//  GenresView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 06.06.2024.
//

import SwiftUI

struct GenresView: View {
    @ObservedObject var viewModel = GenresViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                title
                
                GenresListView(genres: viewModel.genres)
            }
        }
    }
    
    var title: some View {
        ZStack {
            Text("Genres")
                .font(.title)
                .foregroundStyle(.white)
            
            NavigationLink(destination: Text("New genre")) {
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
    GenresView()
}
