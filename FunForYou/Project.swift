import ProjectDescription

let project = Project(
    name: "FunForYou",
    targets: [
        .target(
            name: "FunForYou",
            destinations: .iOS,
            product: .app,
            bundleId: "ada.FunForYou",
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0.0", // 앱 버전
                    "CFBundleVersion": "1", // 빌드 버전
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UIUserInterfaceStyle": "Light",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait",
                    ],
                ]
            ),
            sources: ["FunForYou/Sources/**"],
            resources: ["FunForYou/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "FunForYouTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.FunForYouTests",
            infoPlist: .default,
            sources: ["FunForYou/Tests/**"],
            resources: [],
            dependencies: [.target(name: "FunForYou")]
        ),
    ]
)
