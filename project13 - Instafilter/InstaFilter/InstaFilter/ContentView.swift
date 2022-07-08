//
//  ContentView.swift
//  InstaFilter
//
//  Created by Derek Howes on 5/6/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.0
    @State private var crystalIntensity = 0.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var crystalFilter: CIFilter = CIFilter.sepiaTone()
    
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                    //Select image
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing(currentFilter, scaleValue: filterIntensity) }
                    
                    Text("Crystaly")
                    Slider(value: $crystalIntensity)
                        .onChange(of: crystalIntensity) { _ in applyProcessing(crystalFilter, scaleValue: crystalIntensity) }
                    
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(processedImage == nil)

                }
            }
            .padding([.horizontal,.bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                
                Button("Crystallize") {setFilter(CIFilter.crystallize()) }
                Button("Edges") {setFilter(CIFilter.edges()) }
                Button("Gaussian Blue") {setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") {setFilter(CIFilter.pixellate()) }
                Button("Sepia") {setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") {setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") {setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        crystalFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing(currentFilter, scaleValue: filterIntensity)
    
    }
    
    func applyProcessing(_ filter: CIFilter, scaleValue: Double) {
        if processedImage != nil {
            let currentImage = CIImage(image: processedImage!)
            filter.setValue(currentImage, forKey: kCIInputImageKey)

        }
            
        let filterInputKeys = filter.inputKeys
                
        if filterInputKeys.contains(kCIInputIntensityKey) {
        filter.setValue(scaleValue, forKey: kCIInputIntensityKey)
        }
        if filterInputKeys.contains(kCIInputRadiusKey) {
        filter.setValue(scaleValue * 200, forKey: kCIInputRadiusKey)
        }
        if filterInputKeys.contains(kCIInputScaleKey) {
        filter.setValue(scaleValue * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = filter.outputImage else {
            print("No worky")
            return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func save() {
        guard let processedImage = processedImage else {
            return
        }

        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)" )
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
