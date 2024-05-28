//
//  StoragesListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 27.05.2024.
//

import SwiftUI

struct StoragesListView: View {
    @ObservedObject var viewModel = StoragesViewModel.shared
    
    private let labelHeight: CGFloat = 25
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(viewModel.rooms) { room in
                    Section {
                        ForEach(viewModel.filteredStorages(by: room)) { storage in
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
    //                                    .overlay(alignment: .trailing) {
    //                                        Text("Delete")
    //                                            .foregroundStyle(.white)
    //                                            .frame(width: 100, height: 54)
    //                                            .background(.red)
    //                                            .offset(x: 100)
    //                                            .onTapGesture {
    //
    //                                            }
    //                                    }
    //                                    .offset(x: storageToDelete?.id == storage.id ? -100 : 0)
    //                                    .contentShape(Rectangle())
    //                                    .gesture(
    //                                        DragGesture()
    //                                            .onChanged { gesture in
    //                                                if gesture.translation.width < -50 {
    //                                                    withAnimation {
    //                                                        storageToDelete = storage
    //                                                    }
    //                                                } else {
    //                                                    withAnimation {
    //                                                        storageToDelete = nil
    //                                                    }
    //                                                }
    //                                            }
    //                                    )
                            }
                            
                            Divider()
                        }
                    } header: {
                        Text(room.name)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .frame(height: labelHeight)
                            .background(.colorMain2)
                    }

                    
                    
                }
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
