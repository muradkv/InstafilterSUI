//
//  Constants.swift
//  Instafilter
//
//  Created by murad on 05.09.2026.
//

enum FilterConstants {
    static let intensityRange: ClosedRange<Double> = 0...1
    static let radiusRange: ClosedRange<Double> = 0...100
    static let defaultIntensity: Double = 0.5
    static let defaultRadius: Double = 0.0
    static let reviewThreshold: Int = 20
    static let scaleMultiplier: Double = 10.0
}

enum UserDefaultsKeys {
    static let filterCount = "filterCount"
}
