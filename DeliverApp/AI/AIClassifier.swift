//
//  AIClassifier.swift
//  DeliverApp
//
//  Created by Evan Wong on 23/1/2024.
//

import Foundation
import UIKit
import CoreML
import Vision

class AIClassifier {
    let model: MobileNetV2

    init() {
        model = try! MobileNetV2(configuration: MLModelConfiguration())
    }

    func classifyImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let resizedImage = image.resize(to: CGSize(width: 224, height: 224)),
              let pixelBuffer = resizedImage.pixelBuffer() else {
            completion(.failure(ClassificationError.invalidImage))
            return
        }

        // Perform image classification
        do {
            let prediction = try model.prediction(image: pixelBuffer)
            let foodType = prediction.classLabel
            completion(.success(foodType))
        } catch {
            completion(.failure(error))
        }
    }
}

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func pixelBuffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let options: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]

        guard let cgImage = self.cgImage else {
            return nil
        }

        let status = CVPixelBufferCreate(kCFAllocatorDefault, cgImage.width, cgImage.height, kCVPixelFormatType_32BGRA, options as CFDictionary, &pixelBuffer)

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])
        defer { CVPixelBufferUnlockBaseAddress(buffer, []) }

        let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer),
                                width: cgImage.width,
                                height: cgImage.height,
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))

        return buffer
    }
}




enum ClassificationError: Error {
    case invalidImage
}


