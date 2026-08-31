//
//  Untitled.swift
//  Instafilter
//
//  Created by murad on 31.08.2026.
//

import SwiftUI

struct FilterSliderView: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let onChange: () -> Void
    let isEnabled: Bool
    
    var body: some View {
        HStack {
            Text(title)
            Slider(value: $value, in: range)
                .onChange(of: value) { _, _ in
                    onChange()
                }
                .disabled(!isEnabled)
        }
    }
}

#Preview {
    FilterSliderView(
        title: "Intensity",
        value: .constant(0.5),
        range: 0...1,
        onChange: {},
        isEnabled: true
    )
}
