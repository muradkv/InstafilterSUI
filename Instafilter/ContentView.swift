//
//  ContentView.swift
//  Instafilter
//
//  Created by murad on 11.08.2026.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var image: Image?
    
    var body: some View {
        VStack(spacing: 20) {
            image?
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
            
            HStack(spacing: 16) {
                Button("Load Example") {
                    loadFilteredExample()
                }
                .buttonStyle(.borderedProminent)
                
                PhotosPicker("Select from Photos", selection: $pickerItem, matching: .images)
                    .buttonStyle(.bordered)
            }
        }
        .padding()
        .onChange(of: pickerItem) {
            Task {
                image = try? await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
    
    private func loadFilteredExample() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
