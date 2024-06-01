//
//  ItemListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 29.05.2024.
//

import SwiftUI

typealias ItemListGrouping = Identifiable & Comparable & Hashable & StringRepresentable
struct ItemListView<Item: ItemPickable & StringRepresentable, ItemDestination: View, ItemContent: View>: View {
    let listOfItems: [Item]
    var listOfSortings: [Sorting<Item>]? = nil
    @State private var currentSorting: Sorting<Item>? = nil
    @State private var currentSortingAscending = true
    @ViewBuilder var representation: (Item) -> ItemContent
    @ViewBuilder var destination: (Item) -> ItemDestination
    
    @State private var searchField = ""
    @State private var hideSearch = true
    
    private var showSearch: Bool {
        !hideSearch || (listOfSortings != nil && !listOfSortings!.isEmpty)
    }
    
    func filteredItems() -> [Item] {
        guard !searchField.isEmpty else { return listOfItems }
        return listOfItems.filter { item in
            item.representation.lowercased().contains(searchField.lowercased())
        }
    }
    
    func sortedItems(items: [Item]) -> [Item] {
        guard let currentSorting else { return items.sorted() }
        
        let sortedItems = items.sorted(by: currentSorting.closure)
        return currentSortingAscending ? sortedItems : sortedItems.reversed()
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    // MARK: Search field
                    if showSearch {
                        HStack(spacing: 0) {
                            SearchField(searchText: $searchField)
                            if let listOfSortings, !listOfSortings.isEmpty {
                                SortingMenu(selectedSorting: $currentSorting, ascending: $currentSortingAscending, listOfSortings: listOfSortings)
                                    .padding(.trailing, 10)
                            }
                        }
                        .background(.colorMain4)
                    }
                    
                    Section {
                        ListOfItems(items: sortedItems(items: filteredItems()))
                    } header: {
                        if !showSearch {
                            Button {
                                withAnimation {
                                    hideSearch = false
                                    proxy.scrollTo("search", anchor: .top)
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .contentShape(Circle())
                            }
                            .font(.subheadline)
                            .foregroundStyle(.colorMain)
                            .frame(height: 25)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .background(.colorMain4)
                        }
                    }
                }
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if !hideSearch && searchField.isEmpty {
                            withAnimation {
                                hideSearch = true
                            }
                        }
                    }
            )
        }
        .background(.white)
        .onAppear {
            currentSorting = listOfSortings?.first
        }
    }
    
    @ViewBuilder
    func ListOfItems(items: [Item]) -> some View {
        ForEach(items) { item in
            NavigationLink(destination: destination(item)) {
                representation(item)
            }
            
            Divider()
        }
    }
}

private struct SortingMenu<Item>: View {
    @Binding var selectedSorting: Sorting<Item>?
    @Binding var ascending: Bool
    let listOfSortings: [Sorting<Item>]
    
    var body: some View {
        Menu {
            Menu("Sort by") {
                ForEach(listOfSortings, id: \.by) { sorting in
                    Button(action: { setSelectedSorting(to: sorting) } ) {
                        if selectedSorting == sorting {
                            Label(sorting.by, systemImage: "checkmark")
                        } else {
                            Text(sorting.by)
                        }
                    }
                }
                Divider()
                Button(action: setToAscending){
                    if ascending {
                        Label("Ascending", systemImage: "checkmark")
                    } else {
                        Text("Ascending")
                    }
                }
                
                Button(action: setToDescending){
                    if !ascending {
                        Label("Descending", systemImage: "checkmark")
                    } else {
                        Text("Desscending")
                    }
                }
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
                .font(.headline)
                .foregroundStyle(.colorMain)
        }
    }
    
    func setSelectedSorting(to newSorting: Sorting<Item>) {
        withAnimation {
            selectedSorting = newSorting
        }
    }
    
    func setToAscending() {
        withAnimation {
            ascending = true
        }
    }
    
    func setToDescending() {
        withAnimation {
            ascending = false
        }
    }
}

struct ItemGrouppedListView<Item: ItemPickable & StringRepresentable, ItemDestination: View, ItemContent: View, ItemGrouping: ItemListGrouping>: View {
    let listOfItems: [Item]
    var groupingParameter: KeyPath<Item, ItemGrouping>
    var listOfSortings: [Sorting<Item>]? = nil
    @State private var currentSorting: Sorting<Item>? = nil
    @State private var currentSortingAscending = true
    @ViewBuilder var representation: (Item) -> ItemContent
    @ViewBuilder var destination: (Item) -> ItemDestination
    
    @State private var searchField = ""
    @State private var hideSearch = true
    
    private var showSearch: Bool {
        !hideSearch || (listOfSortings != nil && !listOfSortings!.isEmpty)
    }
    
    var groups: [ItemGrouping] {
        Set(listOfItems.map{ $0[keyPath: groupingParameter] }).sorted()
    }
    
    func filteredItems() -> [Item] {
        guard !searchField.isEmpty else { return listOfItems }
        return listOfItems.filter { item in
            item.representation.lowercased().contains(searchField.lowercased())
        }
    }
    
    func filteredItems(by group: ItemGrouping) -> [Item] {
        filteredItems().filter { $0[keyPath: groupingParameter] == group }
    }
    
    func sortedItems(items: [Item]) -> [Item] {
        guard let currentSorting else { return items.sorted() }
        
        let sortedItems = items.sorted(by: currentSorting.closure)
        return currentSortingAscending ? sortedItems : sortedItems.reversed()
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    // MARK: Search field
                    if showSearch {
                        HStack(spacing: 0) {
                            SearchField(searchText: $searchField)
                            
                            if let listOfSortings, !listOfSortings.isEmpty {
                                SortingMenu(selectedSorting: $currentSorting, ascending: $currentSortingAscending, listOfSortings: listOfSortings)
                                    .padding(.trailing, 10)
                            }
                        }
                        .background(.colorMain4)
                    }
                    
                    let groups = groups
                    ForEach(groups) { group in
                        let items = filteredItems(by: group)
                        if items.count > 0 {
                            Section {
                                ListOfItems(items: sortedItems(items: items))
                            } header: {
                                Text(group.representation)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.colorMain)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .padding(.vertical, 2)
                                    .background(.colorMain4)
                            }
                        }
                    }
                }
            }
            .overlay {
                if !showSearch {
                    Button {
                        withAnimation {
                            hideSearch = false
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .contentShape(Circle())
                    }
                    .font(.subheadline)
                    .foregroundStyle(.colorMain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.top, 2)
                    .padding(.horizontal)
                        
                }
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if !hideSearch && searchField.isEmpty {
                            withAnimation {
                                hideSearch = true
                            }
                        }
                    }
            )
        }
        .background(.white)
        .onAppear {
            currentSorting = listOfSortings?.first
        }
    }
    
    @ViewBuilder
    func ListOfItems(items: [Item]) -> some View {
        ForEach(items) { item in
            NavigationLink(destination: destination(item)) {
                representation(item)
            }
            
            Divider()
        }
    }
}

private struct SearchField: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Search", text: $searchText)
            
            if !searchText.isEmpty {
                Button {
                    withAnimation {
                        searchText = ""
                    }
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(10)
        .background(.colorMain4)
    }
}


private struct ItemListViewDemo: View {
    let storages = StoragesViewModel.shared.storages
    
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        NavigationView {
            ItemListView(listOfItems: storages) { storage in
                HStack {
                    Group {
                        if let image = storage.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .opacity(0.7)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.colorMain3)
                        }
                    }
                    .frame(width: itemHeight-11)
                    .clipShape(Circle())
                    
                    
                    Text(storage.name)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.headline)
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .frame(height: itemHeight-1)
            } destination: { storage in
                StorageDetailsView(storage: storage)
            }
            .navigationBarHidden(true)
        }
    }
}

private struct ItemListViewDemo2: View {
    let storages = StoragesViewModel.shared.storages
    
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        NavigationView {
            ItemGrouppedListView(listOfItems: storages, groupingParameter: \.room, listOfSortings: MyStorage.sortings) { storage in
                HStack {
                    Group {
                        if let image = storage.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .opacity(0.7)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.colorMain3)
                        }
                    }
                    .frame(width: itemHeight-11)
                    .clipShape(Circle())
                    
                    
                    Text(storage.name)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.headline)
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .frame(height: itemHeight-1)
            } destination: { storage in
                StorageDetailsView(storage: storage)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ItemListViewDemo()
}
#Preview {
    ItemListViewDemo2()
}
