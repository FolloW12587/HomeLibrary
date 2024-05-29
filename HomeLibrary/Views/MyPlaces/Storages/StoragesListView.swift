//
//  StoragesListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 27.05.2024.
//

import SwiftUI

struct StoragesListView: View {
    var storages: [MyStorage] = StoragesViewModel.shared.storages
    
    @State private var searchField = ""
    @State private var hideSearch = true
    
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ItemGrouppedListView(listOfItems: storages, groupingParameter: \.room) { storage in
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
                .frame(width: itemHeight-11)
                .clipShape(Circle())
                
                
                Text(storage.name)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(height: itemHeight-1)
        } destination: { storage in
            StorageDetailsView(storage: storage)
        }
    }
}

#Preview {
    NavigationView {
        StoragesListView()
    }
}
