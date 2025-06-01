//
//  AppDelegate.swift
//  FunForYou
//
//  Created by 배현진 on 6/1/25.
//
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FunForYouFontFamily.registerAllCustomFonts()
        return true
    }
}
