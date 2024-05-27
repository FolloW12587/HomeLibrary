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
    
    private let labelHeight: CGFloat = 25
    private let itemHeight: CGFloat = 55
    
    @State private var offset: CGPoint = .zero
    // вычисление текущей комнаты для "приклеенного" лейбла
    // происходит не очень эффективно, тк происходит много затратных операций при каждом обновлении экрана
    // можно сделать более эффективно тем, что высчитать это все один раз (а также обновлять при обновлении списка), а затем отдавать комнату на основе рассчитанных значений
    private var currentRoom: Room? {
        let rooms = viewModel.rooms
        guard !rooms.isEmpty else { return nil }
        
        guard offset.y >= 0 else { return rooms.first }
        
        var calculatedOffset: CGFloat = 0
        for room in rooms {
            var thisOffset: CGFloat = labelHeight
            
            let storagesCount = viewModel.filteredStorages(by: room).count
            thisOffset += CGFloat(storagesCount) * itemHeight
            if offset.y >= calculatedOffset && offset.y < calculatedOffset + thisOffset {
                return room
            }
            calculatedOffset += thisOffset
        }
        return rooms.last
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                title
                
                OffsetObservingScrollView(offset: $offset) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.rooms) { room in
                            Text(room.name)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .frame(height: labelHeight)
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
                        }
                    }
                }
                .background(.white)
                .overlay(alignment: .top) {
                    if let room = currentRoom {
                        Text(room.name)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .frame(height: labelHeight)
                            .background(.colorMain2)
                    }
                }
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
