//
//  InstafilterView.swift
//  Instafilter
//
//  Created by murad on 18.08.2026.
//

import SwiftUI

struct InstafilterView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView(
                        "No Picture",
                        systemImage: "photo.badge.plus",
                        description: Text("Tap to import a photo")
                    )
                }
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                    
                    // share the picture
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    
    private func changeFilter() {
        print("Change filter tapped")
    }
}

#Preview {
    InstafilterView()
}
