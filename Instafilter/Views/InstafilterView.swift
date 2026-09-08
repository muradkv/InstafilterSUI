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
    @Environment(\.requestReview) private var requestReview
    @AppStorage(UserDefaultsKeys.filterCount) private var filterCount = 0
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
                
                if let _ =  viewModel.currentFilterModel {
                    if viewModel.supportsIntensity {
                        FilterSliderView(
                            title: "Intensity",
                            value: $viewModel.filterIntensity,
                            range: FilterConstants.intensityRange,
                            onChange: viewModel.applyProcessing,
                            isEnabled: viewModel.processedImage != nil
                        )
                    }
                    
                    if viewModel.supportsRadius {
                        FilterSliderView(
                            title: "Radius",
                            value: $viewModel.filterRadius,
                            range: FilterConstants.radiusRange,
                            onChange: viewModel.applyProcessing,
                            isEnabled: viewModel.processedImage != nil
                        )
                    }
                }
                
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
                ForEach(FilterModel.allFilters) { filterModel in
                    Button(filterModel.name) {
                        setFilter(filterModel.filter)
                    }
                }
                
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    @MainActor private func setFilter(_ filter: CIFilter) {
        filterCount += 1
        
        viewModel.setFilter(filter)
        
        if filterCount == FilterConstants.reviewThreshold {
            requestReview()
        }
    }
}

#Preview {
    InstafilterView()
}
