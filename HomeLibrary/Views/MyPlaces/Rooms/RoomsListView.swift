//
//  RoomsListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 27.05.2024.
//

import SwiftUI

struct RoomsListView: View {
    @ObservedObject var viewModel = RoomsViewModel.shared
    
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ItemListView(listOfItems: viewModel.rooms) { room in
            HStack {
                Text(room.name)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(height: itemHeight-1)
        } destination: { room in
            RoomDetailsView(room: room)
        }
    }
}

#Preview {
    NavigationView {
        RoomsListView()
    }
}
