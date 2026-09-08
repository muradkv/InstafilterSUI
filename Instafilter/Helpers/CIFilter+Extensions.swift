//
//  Untitled.swift
//  Instafilter
//
//  Created by murad on 08.09.2026.
//

import CoreImage
import CoreImage.CIFilterBuiltins

extension CIFilter {
    var supportsIntensity: Bool {
        inputKeys.contains(kCIInputIntensityKey)
    }
    
    var supportsRadius: Bool {
        inputKeys.contains(kCIInputRadiusKey)
    }
    
    var supportsScale: Bool {
        inputKeys.contains(kCIInputScaleKey)
    }
}
