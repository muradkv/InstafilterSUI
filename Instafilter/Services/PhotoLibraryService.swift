//
//  PhotoLibraryService.swift
//  Instafilter
//
//  Created by murad on 09.09.2026.
//

import UIKit
import Photos

protocol PhotoLibraryServiceProtocol {
    func saveImage(_ image: UIImage) async throws
}

final class PhotoLibraryService: PhotoLibraryServiceProtocol {
    func saveImage(_ image: UIImage) async throws {

        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        switch status {
        case .authorized, .limited:
            try await withCheckedThrowingContinuation { continuation in
                PHPhotoLibrary.shared().performChanges {
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                } completionHandler: { success, error in
                    if success {
                        continuation.resume()
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: NSError(domain: "PhotoLibraryService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
                    }
                }
            }
            
        case .notDetermined:
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
            if newStatus == .authorized || newStatus == .limited {
                try await saveImage(image)
            } else {
                throw NSError(domain: "PhotoLibraryService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Access denied"])
            }
            
        case .denied, .restricted:
            throw NSError(domain: "PhotoLibraryService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Access denied"])
            
        @unknown default:
            throw NSError(domain: "PhotoLibraryService", code: -4, userInfo: [NSLocalizedDescriptionKey: "Unknown authorization status"])
        }
    }
}
