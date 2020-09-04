// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Lottie",
  platforms: [.macOS(.v10_14), .iOS(.v9)],
  products: [
    .library(name: "Lottie", targets: ["Lottie"])
  ],
  targets: [
    .target(
      name: "Lottie",
      path: "lottie-swift/src"
    )
  ]
)
