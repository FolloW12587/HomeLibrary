//
//  ItemPickerView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 27.05.2024.
//

import SwiftUI

typealias ItemPickable = Hashable & Identifiable & Comparable
struct ItemPickerView<Item: ItemPickable & StringRepresentable>: View {
    let title: LocalizedStringKey
    
    @Binding var selectedItem: Item
    let selections: any Sequence<Item>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                
                ForEach(selections.sorted()) { item in
                    HStack {
                        Text(item.representation)
                        
                        Spacer()
                        
                        if selectedItem == item {
                            Image(systemName: "checkmark")
                        }
                    }
                    .foregroundStyle(item == selectedItem ? .accent : .black)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .frame(height: 54)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            selectedItem = item
                        }
                    }
                    
                    Divider()
                }
            }
            .padding(.top)
        }
    }
}

private struct ItemPickerViewDemo: View {
    @State var room = RoomsViewModel.shared.rooms.first!
    
    var body: some View {
        ItemPickerView(title: "Choose room", selectedItem: $room, selections: RoomsViewModel.shared.rooms)
    }
}

#Preview {
    ItemPickerViewDemo()
}
