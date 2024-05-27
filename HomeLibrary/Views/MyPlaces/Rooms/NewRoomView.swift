//
//  NewRoomView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 27.05.2024.
//

import SwiftUI

struct NewRoomView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = RoomsViewModel.shared
    @State var roomName = ""
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Name")
                    .font(.headline)
                
                TextField("", text: $roomName)
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
            .disabled(roomName.isEmpty)
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
            
            
            Text("New room")
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
        guard roomName.isEmpty else { return }
        
        viewModel.newRoom(name: roomName)
        dismiss()
    }
}

#Preview {
    NewRoomView()
}
