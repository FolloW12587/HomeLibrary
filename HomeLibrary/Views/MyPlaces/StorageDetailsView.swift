//
//  StorageDetailsView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 13.05.2024.
//

import SwiftUI

struct StorageDetailsView: View {
    let storage: MyStorage
    
    var body: some View {
        Form {
            Text(storage.name)
        }
    }
}

#Preview {
    StorageDetailsView(storage: MyStorage.examples[0])
}
