//
//  RoomsViewModel.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 26.05.2024.
//

import Foundation


class RoomsViewModel: ObservableObject {
    static var shared = RoomsViewModel()
    
    @Published var rooms: [Room] = StoragesViewModel.shared.rooms
    private init() {}
    
    func newRoom(name: String) {
        guard !name.isEmpty else { return }
        
        rooms.append(Room(name: name))
    }
}
