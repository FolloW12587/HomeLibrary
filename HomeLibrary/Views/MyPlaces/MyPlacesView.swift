//
//  MyPlacesView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 13.05.2024.
//

import SwiftUI

struct MyPlacesView: View {
    @State private var currentTab: Tabs = .storages
    @ObservedObject var storagesViewModel = StoragesViewModel.shared
    
    private let itemHeight: CGFloat = 55
     
    @Namespace private var namespace
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                title
                
                switch currentTab {
                case .storages:
                    StoragesListView(storages: storagesViewModel.storages)
                        .transition(.move(edge: .leading))
                case .room:
                    RoomsListView()
                        .transition(.move(edge: .trailing))
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Верхний хеадер с заголовком, табом и добавлением нового элемента
    var title: some View {
        ZStack {
            VStack(spacing: 15) {
                Text("Storages")
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack(spacing: 30) {
                    tabLabel(.storages, title: "Storages")
                    
                    tabLabel(.room, title: "Rooms")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            Group {
                switch currentTab {
                case .storages:
                    NavigationLink(destination: NewStorageView()) {
                        Image(systemName: "plus")
                    }
                case .room:
                    NavigationLink(destination: NewRoomView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .font(.headline)
            .foregroundStyle(.accent)
            .padding(.top, 8)
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity)
        .background {
            Color.сolorMain
                .ignoresSafeArea()
        }
    }
    
    // Выбор таба - показывать хранилища или комнаты
    fileprivate func tabLabel(_ tab: Tabs, title: LocalizedStringKey) -> some View {
        Text(title)
            .font(.subheadline.bold())
            .foregroundStyle(currentTab == tab ? .accent : .colorMain3)
            .padding(.bottom, 10)
            .frame(minWidth: 100)
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
    case storages, room
}

#Preview {
    MyPlacesView()
}
