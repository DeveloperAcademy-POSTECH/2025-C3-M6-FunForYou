import ProjectDescription

let project = Project(
    name: "FunForYou",
    targets: [
        .target(
            name: "FunForYou",
            destinations: .iOS,
            product: .app,
            bundleId: "com.ADA.FunForYou",
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
                    "UIAppFonts": [
                        "KimjungchulGothic-Bold.otf",
                        "KimjungchulGothic-Light.otf",
                        "KimjungchulGothic-Regular.otf",
                        "KimjungchulMyungjo-Bold.otf",
                        "KimjungchulMyungjo-Light.otf",
                        "KimjungchulMyungjo-Regular.otf",
                        "KimjungchulScript-Bold.otf",
                        "KimjungchulScript-Light.otf",
                        "KimjungchulScript-Regular.otf",
                        "Pretendard-Black.otf",
                        "Pretendard-Bold.otf",
                        "Pretendard-ExtraBold.otf",
                        "Pretendard-ExtraLight.otf",
                        "Pretendard-Light.otf",
                        "Pretendard-Medium.otf",
                        "Pretendard-Regular.otf",
                        "Pretendard-SemiBold.otf",
                        "Pretendard-Thin.otf",
                    ],
                    "UIBackgroundModes": ["remote-notification"],
                    "FirebaseAppDelegateProxyEnabled": false,
                ]
            ),
            sources: ["FunForYou/Sources/**"],
            resources: ["FunForYou/Resources/**"],
            entitlements: .file(path: .relativeToRoot("FunForYou/FunForYou.entitlements")),
            dependencies: [
                .external(name: "FirebaseMessaging"),
                .external(name: "FirebaseCore"),
                .external(name: "FirebaseDatabase")
            ],
            settings: .settings(
                base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"]
            )
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
