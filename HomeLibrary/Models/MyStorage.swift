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
