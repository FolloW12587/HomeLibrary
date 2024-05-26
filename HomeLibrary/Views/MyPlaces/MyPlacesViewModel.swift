//
//  MyPlacesViewModel.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 26.05.2024.
//

import Foundation


class MyPlacesViewModel: ObservableObject {
    static var shared = MyPlacesViewModel()
    
    @Published var storages: [MyStorage] = MyStorage.examples
    
    private init() {}
    
    var rooms: [Room] {
        let rooms = storages.map{ $0.room }
        let uniqueRooms = Set(rooms)
        return uniqueRooms.sorted()
    }
    
    func filteredStorages(by room: Room) -> [MyStorage] {
        storages.filter { $0.room == room }
    }
}
