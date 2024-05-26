//
//  MyPlacesView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 13.05.2024.
//

import SwiftUI

struct MyPlacesView: View {
    @ObservedObject var viewModel = MyPlacesViewModel.shared
    
//    @State private var storageToDelete: MyStorage? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                title
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.rooms) { room in
                            Text(room.name)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .frame(height: 25)
                                .background(.colorMain2)
                            
                            
                            
                            ForEach(viewModel.filteredStorages(by: room)) { storage in
                                NavigationLink(destination: Text(storage.name)) {
                                    HStack {
                                        Group {
                                            if let image = storage.image {
                                                image
                                                    .resizable()
                                            } else {
                                                Image(systemName: "photo.circle.fill")
                                                    .resizable()
                                                    .opacity(0.7)
                                            }
                                        }
                                        .aspectRatio(contentMode: .fit)
                                        
                                        
                                        Text(storage.name)
                                            .foregroundStyle(.black)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.headline)
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal)
                                    .frame(height: 54)
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
                        }
                    }
                }
                .background(.white)
            }
            .navigationBarHidden(true)
        }
    }
    
    var title: some View {
        ZStack {
            Text("Storages")
                .font(.title)
                .foregroundStyle(.white)
            
            NavigationLink(destination: NewStorageView()) {
                Image(systemName: "plus")
                    .font(.headline)
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            Color.сolorMain
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MyPlacesView()
}
