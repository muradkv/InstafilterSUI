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
        
    private let imageService: ImageProcessingServiceProtocol
    private var inputImage: UIImage?
    
    init(imageService: ImageProcessingServiceProtocol = ImageProcessingService()) {
        self.imageService = imageService
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: imageData) else { return }
            
            inputImage = uiImage
            applyProcessing()
        }
    }
    
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
