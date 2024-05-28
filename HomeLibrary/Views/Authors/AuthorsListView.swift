//
//  AuthorsListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import SwiftUI

struct AuthorsListView: View {
    var authors: [Author] = AuthorsViewModel.shared.authors
    
    @State private var searchField = ""
    @State private var hideSearch = true
    
    private func filteredAuthors() -> [Author] {
        guard !searchField.isEmpty else { return authors }
        return authors.filter { author in
            author.representation.lowercased().contains(searchField.lowercased())
        }
    }
    
    private let itemHeight: CGFloat = 55
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    // MARK: Search field
                    HStack(spacing: 5) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        
                        TextField("Search", text: $searchField)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(10)
                    .frame(height: hideSearch ? 0 : 70)
                    .opacity(hideSearch ? 0 : 1)
                    .background(.colorMain3)
                    .brightness(0.2)
                    .id("search")
                    
                    
                    let filtered = filteredAuthors().sorted()
                    Section {
                        ForEach(filtered) { author in
                            NavigationLink(destination: Text(author.representation)) {
                                HStack {
                                    Text(author.representation)
                                        .foregroundStyle(.black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .frame(height: itemHeight-1)
                            }
                            Divider()
                        }
                    } header: {
                        if hideSearch {
                            Button {
                                withAnimation {
                                    hideSearch = false
                                    proxy.scrollTo("search", anchor: .top)
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .contentShape(Circle())
                            }
                            .font(.headline)
                            .frame(height: 25)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .background(.colorMain3)
                            .brightness(0.2)
                        }
                    }
                }
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation {
                            hideSearch = true
                        }
                    }
            )
        }
    }
}

#Preview {
    NavigationView {
        AuthorsListView()
    }
}
