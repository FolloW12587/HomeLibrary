//
//  StorageDetailsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 13.05.2024.
//

import SwiftUI

struct StorageDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let storage: MyStorage
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 10) {
                Text(storage.name)
                    .font(.title.bold())
                
                // TODO: Change destination
                NavigationLink(destination: RoomDetailsView(room: storage.room)) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text(storage.room.name)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .offset(y: -25)
            
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
            if let image = storage.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 50)
            .padding()
        }
        .ignoresSafeArea()
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background {
            Color.colorMain3
                .ignoresSafeArea()
            
            Image(systemName: "photo")
                .font(.title)
                .foregroundStyle(.white)
        
        }
    }
}

#Preview {
    NavigationView {
        StorageDetailsView(storage: MyStorage.examples[0])
    }
}
