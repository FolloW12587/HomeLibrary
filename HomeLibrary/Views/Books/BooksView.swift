//
//  BooksView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 01.06.2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var viewModel = BooksViewModel.shared
    @State private var currentTab: Tabs = .all
    
    @Namespace private var namespace
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                title
                
                switch currentTab {
                case .all:
                    BooksListView(books: viewModel.books)
                        .transition(.move(edge: .leading))
                case .series:
                    SeriesListView()
                        .transition(.move(edge: .trailing))
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    var title: some View {
        ZStack {
            VStack(spacing: 15) {
                Text("Books")
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack(spacing: 30) {
                    tabLabel(.all, title: "All")
                    
                    tabLabel(.series, title: "Series")
                    
//                    tabLabel(.tags, title: "Tags")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            NavigationLink {
                switch currentTab {
                case .all:
                    Text("New book")
                case .series:
                    Text("New series")
                }
            } label: {
                Image(systemName: "plus")
                    .font(.headline)
            }
            .font(.headline)
            .foregroundStyle(.accent)
            .padding(.top, 8)
        }
        .padding([.horizontal, .top])
        .background {
            Color.colorMain
                .ignoresSafeArea()
        }
    }
    
    fileprivate func tabLabel(_ tab: Tabs, title: LocalizedStringKey) -> some View {
        Text(title)
            .font(.subheadline.bold())
            .foregroundStyle(currentTab == tab ? .accent : .colorMain3)
            .padding(.bottom, 10)
            .frame(minWidth: 80)
            .background(alignment: .bottom) {
                if currentTab == tab {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.accent, lineWidth: 2)
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "tabLine", in: namespace)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    currentTab = tab
                }
            }
    }
}

fileprivate enum Tabs {
    case all, series //, tags
}

#Preview {
    BooksView()
}
