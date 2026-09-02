//
//  ImageProcessingService.swift
//  Instafilter
//
//  Created by murad on 02.09.2026.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

protocol ImageProcessingServiceProtocol {
    func applyFilter(
        to image: UIImage,
        filter: CIFilter,
        intensity: Double?,
        radius: Double?,
        scale: Double?
    ) -> UIImage?
}

final class ImageProcessingService: ImageProcessingServiceProtocol {
    private let context = CIContext()
    
    func applyFilter(
        to image: UIImage,
        filter: CIFilter,
        intensity: Double? = nil,
        radius: Double? = nil,
        scale: Double? = nil
    ) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        let inputKeys = filter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey), let intensity {
            filter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey), let radius {
            filter.setValue(radius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey), let scale {
            filter.setValue(scale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}
