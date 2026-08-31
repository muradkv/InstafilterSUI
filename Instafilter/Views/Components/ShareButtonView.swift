//
//  Untitled.swift
//  Instafilter
//
//  Created by murad on 31.08.2026.
//

import SwiftUI

struct ShareButtonView: View {
    let image: Image
    
    var body: some View {
        ShareLink(
            item: image,
            preview: SharePreview("Instafilter image", image: image)
        )
    }
}

#Preview {
    ShareButtonView(image: Image(systemName: "photo"))
}
