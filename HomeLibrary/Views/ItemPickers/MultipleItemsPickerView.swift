//
//  MultipleItemsPickerView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import SwiftUI

struct MultipleItemsPickerView<Item: ItemPickable & StringRepresentable>: View {
    let title: LocalizedStringKey
    
    @Binding var selectedItems: Set<Item>
    let selections: any Sequence<Item>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                
                ForEach(selections.sorted()) { item in
                    let contains = selectedItems.contains(item)
                    HStack {
                        Text(item.representation)
                        
                        Spacer()
                        
                        if contains {
                            Image(systemName: "checkmark")
                        }
                    }
                    .foregroundStyle(contains ? .accent : .black)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .frame(height: 54)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            if contains {
                                selectedItems.remove(item)
                            } else {
                                selectedItems.insert(item)
                            }
                        }
                    }
                    
                    Divider()
                }
            }
            .padding(.top)
        }
    }
}

private struct MultipleItemsPickerViewDemo: View {
    @State var selected = Set<Room>()
    
    var body: some View {
        MultipleItemsPickerView(title: "Choose genres", selectedItems: $selected, selections: RoomsViewModel.shared.rooms)
    }
}

#Preview {
    MultipleItemsPickerViewDemo()
}
