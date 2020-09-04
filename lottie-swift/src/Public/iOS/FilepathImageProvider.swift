//
//  FilepathImageProvider.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/1/19.
//

import Foundation
#if canImport(UIKit)
    import UIKit
#endif

#if canImport(AppKit)
    import AppKit
#endif

/**
 Provides an image for a lottie animation from a provided Bundle.
 */
public class FilepathImageProvider: AnimationImageProvider {
    let filepath: URL

    /**
     Initializes an image provider with a specific filepath.

     - Parameter filepath: The absolute filepath containing the images.

     */
    public init(filepath: String) {
        self.filepath = URL(fileURLWithPath: filepath)
    }

    public init(filepath: URL) {
        self.filepath = filepath
    }

    public func imageForAsset(asset: ImageAsset) -> CGImage? {
        #if canImport(UIKit)
            if asset.name.hasPrefix("data:"),
                let url = URL(string: asset.name),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image.cgImage
            }
        #endif

        #if canImport(AppKit)
            if asset.name.hasPrefix("data:"),
                let url = URL(string: asset.name),
                let data = try? Data(contentsOf: url),
                let image = NSImage(data: data) {
                return image.CGImage
            }
        #endif

        let directPath = filepath.appendingPathComponent(asset.name).path
        if FileManager.default.fileExists(atPath: directPath) {
            #if canImport(UIKit)
                return UIImage(contentsOfFile: directPath)?.cgImage
            #endif
            #if canImport(AppKit)
                return NSImage(contentsOfFile: directPath)?.CGImage
            #endif
        }

        let pathWithDirectory = filepath.appendingPathComponent(asset.directory).appendingPathComponent(asset.name).path
        if FileManager.default.fileExists(atPath: pathWithDirectory) {
            #if canImport(UIKit)
                return UIImage(contentsOfFile: pathWithDirectory)?.cgImage
            #endif
            #if canImport(AppKit)
                return NSImage(contentsOfFile: pathWithDirectory)?.CGImage
            #endif
        }

        return nil
    }
}

#if canImport(AppKit)
    extension NSImage {
        @objc var CGImage: CGImage? {
            guard let imageData = tiffRepresentation else { return nil }
            guard let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
            return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
        }
    }
#endif
