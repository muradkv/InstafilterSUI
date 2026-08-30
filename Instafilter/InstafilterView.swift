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
                
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let processedImage = viewModel.processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                    }
                }
                .onChange(of: viewModel.selectedItem, viewModel.loadImage)
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $viewModel.filterIntensity)
                        .onChange(of: viewModel.filterIntensity, viewModel.applyProcessing)
                        .disabled(viewModel.processedImage == nil)
                    
                    Text("Radius")
                    Slider(value: $viewModel.filterRadius, in: 0...100)
                        .onChange(of: viewModel.filterRadius, viewModel.applyProcessing)
                        .disabled(viewModel.processedImage == nil)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") { showingFilters = true }
                        .disabled(viewModel.processedImage == nil)
                    
                    Spacer()
                    
                    if let processedImage = viewModel.processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
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
