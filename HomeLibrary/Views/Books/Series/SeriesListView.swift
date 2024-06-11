//
//  SeriesListView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 11.06.2024.
//

import SwiftUI

struct SeriesListView: View {
    @ObservedObject var viewModel = SeriesViewModel.shared
    
    var body: some View {
        ItemListView(listOfItems: viewModel.series, listOfSortings: Series.sortings) { series in
            HStack {
                VStack(alignment: .leading) {
                    Text(series.name)
                        .font(.headline)
                        .foregroundStyle(.colorMain)
                        .lineSpacing(-5)
                    
                    Text(series.author.representation)
                        .font(.subheadline)
                        .foregroundStyle(.colorMain.opacity(0.7))
                }
                
                Spacer(minLength: 10)
                
                Text("\(viewModel.booksCount(of: series)) books")
                    .font(.subheadline)
                    .foregroundStyle(.colorMain.opacity(0.7))
                
                Image(systemName: "chevron.right")
                    .font(.headline)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
        } destination: { series in
            Text(series.name)
        }

    }
}

#Preview {
    NavigationView {
        SeriesListView()
    }
}
