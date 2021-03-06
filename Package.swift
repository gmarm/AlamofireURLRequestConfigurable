// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "AlamofireURLRequestConfigurable",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "AlamofireURLRequestConfigurable",
            targets: ["AlamofireURLRequestConfigurable"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.9.1"),
    ],
    targets: [
        .target(
            name: "AlamofireURLRequestConfigurable",
            dependencies: ["Alamofire"],
            path: "AlamofireURLRequestConfigurable")
    ],
    swiftLanguageVersions: [.v5]
)
