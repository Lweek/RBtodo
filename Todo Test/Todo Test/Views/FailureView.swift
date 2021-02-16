//
//  FailureView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import SwiftUI

struct FailureView: View {
    
    typealias RetryHandler = () -> Void
    
    var onRetryPressed: RetryHandler?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "exclamationmark.icloud.fill")
                .font(.title)
            Text("failed-connection")
            Button("retry") {
                onRetryPressed?()
            }
            .buttonStyle(FilledButtonStyle())
        }
    }
}

struct FailureView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FailureView()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            FailureView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
