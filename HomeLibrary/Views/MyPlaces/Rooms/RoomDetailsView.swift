//
//  RoomDetailsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import SwiftUI

struct RoomDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let room: Room
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 50) {
                Text(room.name)
                    .font(.title.bold())
                
                Text("Storages")
                    .font(.title3.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            .background(.white)
            StoragesListView(storages: StoragesViewModel.shared.filteredStorages(by: room))
            
            Spacer()
            
            // TODO: Implement Delete
            Button(action: {}, label: {
                Text("Delete")
                    .foregroundStyle(.red)
            })
        }
        .navigationBarHidden(true)
    }
    
    var title: some View {
        ZStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            Text("Room details")
                .font(.title)
                .foregroundStyle(.white)
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
    NavigationView {
        RoomDetailsView(room: RoomsViewModel.shared.rooms.first!)
    }
}
