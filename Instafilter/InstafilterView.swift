//
//  InstafilterView.swift
//  Instafilter
//
//  Created by murad on 18.08.2026.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct InstafilterView: View {
    @State private var viewModel = InstafilterViewModel()
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") var filterCount = 0
    @State private var showingFilters = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                ImagePickerView(
                    selectedItem: $viewModel.selectedItem,
                    processedImage: viewModel.processedImage,
                    onImageSelected: viewModel.loadImage
                )
                
                Spacer()
                
                FilterSliderView(
                    title: "Intensity",
                    value: $viewModel.filterIntensity,
                    range: 0...1,
                    onChange: viewModel.applyProcessing,
                    isEnabled: viewModel.processedImage != nil
                )
                
                FilterSliderView(
                    title: "Radius",
                    value: $viewModel.filterRadius,
                    range: 0...100,
                    onChange: viewModel.applyProcessing,
                    isEnabled: viewModel.processedImage != nil
                )
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") { showingFilters = true }
                        .disabled(viewModel.processedImage == nil)
                    
                    Spacer()
                    
                    if let processedImage = viewModel.processedImage {
                        ShareButtonView(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Effect Fade") { setFilter(CIFilter.photoEffectFade()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
                Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    @MainActor private func setFilter(_ filter: CIFilter) {
        filterCount += 1
        
        viewModel.setFilter(filter)
        
        if filterCount == 20 {
            requestReview()
        }
    }
}

#Preview {
    InstafilterView()
}
