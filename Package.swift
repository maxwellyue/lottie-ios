// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Lottie",
  #if os(macOS)
  platforms: [.macOS(.v10_15)],
  #endif
  #if canImport(UIKit)
  platforms: [.iOS(.v9)],
  #endif
  products: [
    .library(name: "Lottie", targets: ["Lottie"])
  ],
  targets: [
    #if os(macOS)
    .target(
      name: "Lottie",
      path: "lottie-swift/src",
      exclude: ["Public/iOS"]
    )
    #endif
    #if canImport(UIKit)
    .target(
      name: "Lottie",
      path: "lottie-swift/src",
      exclude: ["Public/MacOS"]
    )
    #endif
  ]
)
