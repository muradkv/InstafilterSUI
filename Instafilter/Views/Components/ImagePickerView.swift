//
//  Untitled.swift
//  Instafilter
//
//  Created by murad on 31.08.2026.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @Binding var selectedItem: PhotosPickerItem?
    let processedImage: Image?
    let onImageSelected: () -> Void
    
    var body: some View {
        PhotosPicker(selection: $selectedItem) {
            if let processedImage {
                processedImage
                    .resizable()
                    .scaledToFit()
            } else {
                ContentUnavailableView(
                    "No Picture",
                    systemImage: "photo.badge.plus",
                    description: Text("Import a photo to get started")
                )
            }
        }
        .onChange(of: selectedItem) { _, _ in
            onImageSelected()
        }
    }
}

#Preview {
    ImagePickerView(
        selectedItem: .constant(nil),
        processedImage: nil,
        onImageSelected: {}
    )
}
