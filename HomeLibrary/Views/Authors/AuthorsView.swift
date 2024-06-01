//
//  AuthorsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import SwiftUI

struct AuthorsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AuthorsViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                title
                
                AuthorsListView(authors: viewModel.authors)
            }
            .navigationBarHidden(true)
        }
    }
    
    var title: some View {
        ZStack {
            Text("Authors")
                .font(.title)
                .foregroundStyle(.white)
            
            NavigationLink(destination: NewAuthorView()) {
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
    AuthorsView()
}
