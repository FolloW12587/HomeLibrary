//
//  NewAuthorView.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 28.05.2024.
//

import SwiftUI

struct NewAuthorView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = AuthorsViewModel.shared
    @State private var firstName = ""
    @State private var secondName = ""
    @State private var surname = ""
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !secondName.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 0) {
            title
            
            VStack(alignment: .leading, spacing: 10) {
                Text("First name")
                    .font(.headline)
                
                TextField("", text: $firstName)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                    }
                    .padding(.bottom)
                
                Text("Second name")
                    .font(.headline)
                
                TextField("", text: $secondName)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                    }
                    .padding(.bottom)
                
                Text("Surname")
                    .font(.headline)
                
                TextField("", text: $surname)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                    }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.black)
            
            Spacer()
            
            Button {
                withAnimation {
                    save()
                }
            } label: {
                Text("Save")
            }
            .buttonStyle(MainButtonStyle())
            .disabled(!isFormValid)
        }
        .navigationBarHidden(true)
    }
    
    var title: some View {
        ZStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.semibold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("New author")
                .font(.title)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            Color.сolorMain
                .ignoresSafeArea()
        }
    }
    
    func save() {
        guard isFormValid else { return }
        
        viewModel.newAuthor(firstName: firstName, secondName: secondName, surname: surname)
        dismiss()
    }
}

#Preview {
    NewAuthorView()
}
