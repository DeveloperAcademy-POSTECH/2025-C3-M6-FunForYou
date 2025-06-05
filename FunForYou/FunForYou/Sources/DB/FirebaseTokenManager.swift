//
//  FirebaseTokenManager.swift
//  FunForYou
//
//  Created by 한건희 on 6/4/25.
//
import FirebaseCore
import FirebaseDatabase

class FirebaseTokenManager {
    static let shared = FirebaseTokenManager()
    
    private init() { }
    
    func sendTokenToServer(fcmToken: String) async {
        if FirebaseApp.app() == nil {
            print("firebase nil!")
        }
        let tokenRef = Database.database().reference()
        do {
            let result = try await tokenRef.setValue(fcmToken)
            print(result)
        } catch {
            print(error)
        }
    }
}
