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
    var hideSearch = false
    
    private var rooms: [Room] {
        let rooms = storages.map{ $0.room }
        let uniqueRooms = Set(rooms)
        return uniqueRooms.sorted()
    }
    
    private func filteredStorages() -> [MyStorage] {
        guard !searchField.isEmpty else { return storages }
        return storages.filter { storage in
            storage.name.lowercased().contains(searchField.lowercased())
        }
    }
    
    private func filteredStorages(by room: Room) -> [MyStorage] {
        filteredStorages().filter { $0.room == room }
    }
    
    private let labelHeight: CGFloat = 25
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    // MARK: Search field
                    if !hideSearch {
                        HStack {
                            TextField("Search", text: $searchField)
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(10)
                        .background(.colorMain3)
                    }
                    
                    ForEach(rooms) { room in
                        Section {
                            ForEach(filteredStorages(by: room)) { storage in
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
                                }
                                
                                Divider()
                            }
                        } header: {
                            let storages = filteredStorages(by: room)
                            if rooms.count > 1 && !storages.isEmpty {
                                Text(room.name)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .frame(height: labelHeight)
                                    .background(.colorMain3)
                                    .id(room.id)
                            }
                        }
                    }
                }
            }
            .onAppear {
                guard let room = rooms.first else { return }
                proxy.scrollTo(room.id)
            }
        }
        .background(.white)
    }
}

#Preview {
    NavigationView {
        StoragesListView()
    }
}
