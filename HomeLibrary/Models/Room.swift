//
//  Room.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import Foundation

/// Комната в квартире
struct Room: Identifiable, Hashable, Comparable {
    static func < (lhs: Room, rhs: Room) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: UUID = UUID()
    let name: String
    
    static var noRoom = Room(name: "No room")
}
