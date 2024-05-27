//
//  MainButtonStyle.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 27.05.2024.
//

import SwiftUI


struct MainButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding()
            .frame(minWidth: 150)
            .background(backgroundColor(configuration: configuration))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
    
    func backgroundColor(configuration: Configuration) -> Color {
        guard isEnabled else { return .gray }
        return configuration.isPressed ? .accent.opacity(0.7) : .accent
    }
}
