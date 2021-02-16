//
//  LoadingView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            Text("loading")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            LoadingView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
