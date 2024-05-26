//
//  NewStorageView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 26.05.2024.
//

import SwiftUI

struct NewStorageView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = MyPlacesViewModel.shared
    @State var storageName = ""
    @State var room: Room = RoomsViewModel.shared.rooms.first ?? Room.noRoom
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Room")
                    .font(.headline)
                
                if !viewModel.rooms.isEmpty {
                    Picker("", selection: $room) {
                        ForEach(viewModel.rooms) { room in
                            Text(room.name)
                                .tag(room)
                        }
                    }
                }
                NavigationLink(destination: Text("New room")) {
                    Text("Add new room")
                        .foregroundStyle(.accent)
                }
                
                Text("Name")
                    .font(.headline)
                TextField("", text: $storageName)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                    }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.black)
            
            
            Spacer()
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
            
            
            Text("New storage")
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
        NewStorageView()
    }
}
