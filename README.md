# Instafilter

![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.0+-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-147EFB?logo=xcode&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Graphics](https://img.shields.io/badge/Graphics-CoreImage-FF2D55)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-8A2BE2)

A reactive image processing and editing iOS application built natively with SwiftUI, leveraging Apple's Core Image graphics pipeline and modern PhotosUI integration.

Instafilter allows users to import photos seamlessly using an out-of-process picker, apply and configure multiple hardware-accelerated Core Image filters in real-time, adjust dynamic parameters via responsive sliders, and export or share the rendered outputs. The project combines low-level GPU-accelerated image manipulation with a clean, decoupled MVVM architecture.

## Preview

<img width="23%" alt="Start" src="https://github.com/user-attachments/assets/97026bcb-58c4-47b0-801b-17d49ce2a1ff" />
<img width="23%" alt="Add image" src="https://github.com/user-attachments/assets/560a20b3-6b5c-481b-9e16-31faf404f559" />
<img width="23%" alt="Add image 2" src="https://github.com/user-attachments/assets/eb23003d-8ef6-4516-8e59-e5b5ae442802" />
<img width="23%" alt="Save" src="https://github.com/user-attachments/assets/769ea7e6-3fae-4f49-bdd0-036df7ac5793" />

## Features

* **Hardware-Accelerated Filtering:** Processes and renders images using Apple's `Core Image` and `CIContext` backed by GPU shaders via Metal.
* **Privacy-First Photo Import:** Asynchronous, out-of-process photo selection powered by `PhotosUI` and the modern `PhotosPicker` Transferable API without requiring full photo library disk access.
* **Dynamic Parameter Sliders:** Evaluates the active `CIFilter` input keys in real-time and conditionally presents individual adjustment sliders (Intensity, Radius, Scale).
* **Direct Photo Library Export:** Saves processed bitmap images directly to the device's photo library via dedicated service with native permission handling (`PHPhotoLibrary`).
* **Interactive Native Sharing:** Standard system sharing integration using SwiftUI's `ShareLink` for seamless cross-app communication.
* **App Review Integration:** Contextual review prompt using `StoreKit` (`requestReview`) triggered after repeated filter operations to measure engagement.

## About the Project & Challenge

This application was developed as **Project 13 (Days 62-67)** of Paul Hudson's 100 Days of SwiftUI curriculum. 

The baseline tutorial covered integrating Core Image pipelines (`CIImage` → `CIContext` → `CGImage` → `UIImage`), asynchronous photo importation with `PhotosPicker`, and action sheets via `confirmationDialog`. 

Beyond the core course requirements, the codebase underwent comprehensive architectural refactoring to mirror production standards and successfully address all milestone challenges:

* **Separation of Concerns (Services Layer):** Extracted GPU rendering computations and image transformation tasks into `ImageProcessingService`, and photo library write operations into `PhotoLibraryService`. This keeps the presentation layers free of heavy UIKit and Core Image glue code.
* **Modern MVVM with `@Observable`:** Migrated state and lifecycle management to an isolated, `@Observable` view model (`InstafilterViewModel`), centralizing UI mutations, filter switching, and validation.
* **View Composition:** Decomposed the primary screen into reusable, single-responsibility subviews (`FilterSliderView`, `ImagePickerView`, `ShareButtonView`) adhering to atomic UI principles.
* **Challenge 1 (Contextual Controls):** Disabled interactive UI controls (Sliders, Change Filter button, and Share/Save actions) when no image is loaded, reinforcing correct UX boundaries.
* **Challenge 2 (Multi-Parameter Adjustment):** Implemented distinct, independent slider controls for different filter parameters (Intensity, Radius, Scale), displaying controls conditionally depending on the inspected filter's `inputKeys`.
* **Challenge 3 (Extended Filter Palette):** Expanded the standard filter suite with additional Core Image filters (`photoEffectFade`, `gloom`, `comicEffect`) encapsulated within a dedicated `FilterModel`.

🔗 **[Full project challenge description (Day 67)](https://www.hackingwithswift.com/books/ios-swiftui/instafilter-wrap-up)**

## Project Versioning & Changelog

* **v2.0.0 (MVVM Architecture & Photo Library Persistence)** — `commit: 29ecd10`  
  Full architectural refactor to MVVM using `@Observable` (iOS 17+). Extracted UI components (`FilterSliderView`, `ImagePickerView`, `ShareButtonView`), separated processing logic into `ImageProcessingService`, implemented `PhotoLibraryService` for direct album exports with permission handling, and added runtime filter parameter support validation.

* **v1.1.0 (Course Challenges Completion & Extended Filters)** — `commit: 2b3488c`  
  Completed all three official curriculum challenges: disabled UI controls when no image is loaded, integrated a dedicated radius slider control (0–200 range), and introduced three additional Core Image filters (`photoEffectFade`, `gloom`, `comicEffect`).

* **v1.0.0 (Functional MVP Release)** — `commit: 8455d7e`  
  Initial baseline release matching the core course tutorial. Implemented asynchronous photo importation with `PhotosPicker`, sepia tone filtering with adjustable intensity, modal filter selection via `confirmationDialog`, system exports via `ShareLink`, and automatic app review prompts via `StoreKit`.
