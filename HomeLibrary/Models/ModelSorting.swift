//
//  ModelSorting.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 01.06.2024.
//

import SwiftUI

struct Sorting<Item>: Hashable {
    static func == (lhs: Sorting<Item>, rhs: Sorting<Item>) -> Bool {
        lhs.by == rhs.by
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(by)
    }
    
    let by: String
    let closure: (Item, Item) -> Bool
}
