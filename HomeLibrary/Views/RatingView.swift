//
//  RatingView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 01.06.2024.
//

import SwiftUI

struct RatingView: View {
    let rating: Int?
    
    var body: some View {
        HStack(spacing: 3) {
            let rating = min(5, max(0, rating ?? 0))
            ForEach(0..<rating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundStyle(.accent)
            }
            
            ForEach(0..<(5-rating), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundStyle(.colorMain4)
            }

        }
    }
}

#Preview {
    RatingView(rating: 3)
}
