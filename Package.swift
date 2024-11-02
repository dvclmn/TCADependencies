// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "TCADependencies",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0")
  ],
  products: [
    
    .library(name: "TCADependencies", targets: [
      "Popup",
      "WindowSize"
      "Keychain"
    ]),

  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.4.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "24.0.0"),
  ],
  
  targets: [
   
    .target(name: "Popup", dependencies: [.product(name: "Dependencies", package: "swift-dependencies")]),
    .target(name: "WindowSize", dependencies: [.product(name: "Dependencies", package: "swift-dependencies")]),
    .target(name: "Keychain", dependencies: [
      .product(name: "KeychainSwift", package: "keychain-swift"),
      .product(name: "Dependencies", package: "swift-dependencies")
    ]),

    
  ]
)

let swiftSettings: [SwiftSetting] = [
  .enableExperimentalFeature("StrictConcurrency"),
  .enableUpcomingFeature("DisableOutwardActorInference"),
  .enableUpcomingFeature("InferSendableFromCaptures"),
  .enableUpcomingFeature("BareSlashRegexLiterals")
]

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(contentsOf: swiftSettings)
  target.swiftSettings = settings
}
