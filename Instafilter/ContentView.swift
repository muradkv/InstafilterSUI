//
//  ContentView.swift
//  Instafilter
//
//  Created by murad on 11.08.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        image = Image(.example)
    }
}

#Preview {
    ContentView()
}
