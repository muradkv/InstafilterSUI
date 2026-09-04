//
//  Untitled.swift
//  Instafilter
//
//  Created by murad on 04.09.2026.
//

import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterModel: Identifiable {
    let id = UUID()
    let name: String
    let filter: CIFilter
}

extension FilterModel {
    static let allFilters: [FilterModel] = [
        FilterModel(name: "Crystallize", filter: CIFilter.crystallize()),
        FilterModel(name: "Edges", filter: CIFilter.edges()),
        FilterModel(name: "Gaussian Blur", filter: CIFilter.gaussianBlur()),
        FilterModel(name: "Pixellate", filter: CIFilter.pixellate()),
        FilterModel(name: "Sepia Tone", filter: CIFilter.sepiaTone()),
        FilterModel(name: "Unsharp Mask", filter: CIFilter.unsharpMask()),
        FilterModel(name: "Vignette", filter: CIFilter.vignette()),
        FilterModel(name: "Effect Fade", filter: CIFilter.photoEffectFade()),
        FilterModel(name: "Gloom", filter: CIFilter.gloom()),
        FilterModel(name: "Comic Effect", filter: CIFilter.comicEffect())
    ]
}
