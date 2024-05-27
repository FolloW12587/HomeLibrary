//
//  NewStorageView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 26.05.2024.
//

import SwiftUI

struct NewStorageView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = StoragesViewModel.shared
    @State var storageName = ""
    @State var room: Room = RoomsViewModel.shared.rooms.first ?? Room.noRoom
    
    @State var showRoomPicker = false
    
    var isFormValid: Bool {
        room != Room.noRoom && !storageName.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Room")
                    .font(.headline)
                
                // MARK: Room picker
                if !viewModel.rooms.isEmpty {
                    HStack {
                        Text(room.name)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.headline)
                            .foregroundStyle(.accent)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showRoomPicker = true
                    }
                }
                
                // MARK: Add new room
                NavigationLink(destination: NewRoomView()) {
                    Text("Add new room")
                        .font(viewModel.rooms.isEmpty ? .subheadline : .caption)
                        .foregroundStyle(.accent)
                        .onChange(of: viewModel.rooms) { newValue in
                            if newValue.isEmpty {
                                room = Room.noRoom
                            } else if room == Room.noRoom {
                                room = newValue.first!
                            }
                        }
                }
                
                // MARK: Storage name input
                Text("Name")
                    .font(.headline)
                TextField("", text: $storageName)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                    }
                
                // TODO: Add here image adding
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.black)
            
            
            Spacer()
            
            Button {
                withAnimation {
                    save()
                }
            } label: {
                Text("Save")
            }
            .buttonStyle(MainButtonStyle())
            .disabled(!isFormValid)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showRoomPicker){
//            RoomPicker(selectedRoom: $room)
            ItemPickerView(title: "Choose room", selectedItem: $room, selections: viewModel.rooms)
        }
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
    
    func save() {
        guard isFormValid else { return }
        
        viewModel.newStorage(room: room, name: storageName)
        dismiss()
    }
}

#Preview {
    NavigationView {
        NewStorageView()
    }
    .preferredColorScheme(.light)
}
