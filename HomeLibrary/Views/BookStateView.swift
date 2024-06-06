//
//  BookStateView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 06.06.2024.
//

import SwiftUI

struct BookStateView: View {
    let state: Book.BookState
    
    var body: some View {
        Text(state.localized)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).stroke())
            .foregroundStyle(state.color)
    }
}

#Preview {
    BookStateView(state: .read)
}
