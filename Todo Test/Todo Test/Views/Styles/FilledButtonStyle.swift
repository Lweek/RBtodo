//
//  FilledButtonStyle.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minHeight: 44)
            .padding(.horizontal, 20)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.accentColor)
            )
    }
    
}
