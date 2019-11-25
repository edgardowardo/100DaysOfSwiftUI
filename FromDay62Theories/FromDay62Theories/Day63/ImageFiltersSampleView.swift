//
//  ImageFiltersSampleView.swift
//  FromDay62Theories
//
//  Created by EDGARDO AGNO on 25/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins



struct ImageFiltersSampleView: View {
            
    @State private var image: Image?
    @State var filter: Filter
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
        .navigationBarTitle("Filter \(filter.rawValue)")
    }
    
    enum Filter: String {
        case none
        case sepia
        case pixelate
        case crystalize
        case twirl
    }
    
    func currentFilter(_ beginImage: CIImage?, inputImage: UIImage) -> CIFilter {
        switch filter {
        case .sepia, .none:
            let currentFilter = CIFilter.sepiaTone()
            currentFilter.inputImage = beginImage
            currentFilter.intensity = (filter == .none) ? 0 : 1
            return currentFilter
        case .pixelate:
            let currentFilter = CIFilter.pixellate()
            currentFilter.inputImage = beginImage
            currentFilter.scale = 10
            return currentFilter
        case .crystalize:
            let currentFilter = CIFilter.crystallize()
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.radius = 5
            return currentFilter
        case .twirl:
            let currentFilter = CIFilter(name: "CITwirlDistortion")!
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(70, forKey: kCIInputRadiusKey)
            currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
            return currentFilter
        }
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "venus")
            else { return }
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter(beginImage, inputImage: inputImage).outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct ImageFiltersSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFiltersSampleView(filter: .sepia)
    }
}
