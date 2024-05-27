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
            RoomPicker(selectedRoom: $room)
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

private struct RoomPicker: View {
    @ObservedObject var viewModel = StoragesViewModel.shared
    
    @Binding var selectedRoom: Room
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("Choose room")
                    .font(.headline)
                
                ForEach(viewModel.rooms) { room in
                    HStack {
                        Text(room.name)
                        
                        Spacer()
                        
                        if selectedRoom == room {
                            Image(systemName: "checkmark")
                        }
                    }
                    .foregroundStyle(room == selectedRoom ? .accent : .black)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .frame(height: itemHeight-1)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            selectedRoom = room
                        }
                    }
                    
                    Divider()
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    NavigationView {
        NewStorageView()
    }
}
