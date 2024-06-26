//
//  Storage.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 12.05.2024.
//

import SwiftUI

/// Место, где хранятся книги
struct MyStorage: Identifiable {
    let id = UUID()
    let room: Room
    let name: String
    
    // фото места, если нужно
    var image: Image? = nil
    
    static let examples = {
        let guestroom = Room(name: "Гостиная")
        let bedroom = Room(name: "Спальня")
        return [
            MyStorage(room: guestroom, name: "Полка", image: Image("shelf")),
            MyStorage(room: guestroom, name: "Шкаф"),
            MyStorage(room: bedroom, name: "Стеллаж"),
        ]
    }()
}

extension MyStorage: StringRepresentable {
    var representation: String {
        name
    }
}

extension MyStorage: Hashable, Comparable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(room)
        hasher.combine(name)
    }
    
    static func < (lhs: MyStorage, rhs: MyStorage) -> Bool {
        lhs.name < rhs.name
    }
}

extension MyStorage {
    static let sortings: [Sorting<Self>] = [
        Sorting(by: "Name", closure: { $0.name < $1.name }),
        Sorting(by: "Room", closure: { $0.room.name < $1.room.name }),
    ]
}
