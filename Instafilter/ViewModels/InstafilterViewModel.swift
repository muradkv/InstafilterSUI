//
//  InstafilterViewModel.swift
//  Instafilter
//
//  Created by murad on 30.08.2026.
//

import Foundation
import SwiftUI
import PhotosUI
import StoreKit

@Observable
class InstafilterViewModel {
    var processedImage: Image?
    var filterIntensity = FilterConstants.defaultIntensity
    var filterRadius = FilterConstants.defaultRadius
    var selectedItem: PhotosPickerItem?
    var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    var alertMessage: String?
    var alertIsPresented: Bool = false
    
    private let imageService: ImageProcessingServiceProtocol
    private let photoService: PhotoLibraryServiceProtocol
    private var inputImage: UIImage?
    
    var currentFilterModel: FilterModel? {
        FilterModel.allFilters.first { $0.filter.name == currentFilter.name }
    }
    
    var supportsIntensity: Bool {
        currentFilter.supportsIntensity
    }
    
    var supportsRadius: Bool {
        currentFilter.supportsRadius
    }
    
    init(
        imageService: ImageProcessingServiceProtocol = ImageProcessingService(),
        photoService: PhotoLibraryServiceProtocol = PhotoLibraryService()
    ) {
        self.imageService = imageService
        self.photoService = photoService
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                print("⚠️ Failed to load image data")
                return
            }
            
            guard let uiImage = UIImage(data: imageData) else {
                print("⚠️ Failed to create UIImage from data")
                return
            }
            
            inputImage = uiImage
            await applyProcessing()
        }
    }
    
    @MainActor
    func saveImage() async {
        guard let inputImage else {
            alertMessage = "No image to save"
            alertIsPresented = true
            return
        }
        
        guard let uiImage = imageService.applyFilter(
            to: inputImage,
            filter: currentFilter,
            intensity: filterIntensity,
            radius: filterRadius,
            scale: filterIntensity * 10
        ) else {
            alertMessage = "Failed to process image"
            alertIsPresented = true
            return
        }
        
        do {
            try await photoService.saveImage(uiImage)
            alertMessage = "Image saved successfully!"
            alertIsPresented = true
        } catch {
            alertMessage = "Failed to save image: \(error.localizedDescription)"
            alertIsPresented = true
        }
    }
    
    @MainActor
    func applyProcessing() {
        guard let inputImage else { return }
        
        let processedUIImage = imageService.applyFilter(
            to: inputImage,
            filter: currentFilter,
            intensity: filterIntensity,
            radius: filterRadius,
            scale: filterIntensity * FilterConstants.scaleMultiplier
        )
        
        if let processedUIImage {
            processedImage = Image(uiImage: processedUIImage)
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}
