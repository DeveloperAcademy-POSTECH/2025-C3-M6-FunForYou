//
//  ImageManager.swift
//  FunForYou
//
//  Created by 한건희 on 6/2/25.
//

import UIKit

/// 이미지 파일 저장 및 로드 기능을 제공하는 싱글턴 클래스입니다.
/// - 기능: 이미지 저장, 이미지 불러오기, 도큐먼트 디렉토리 경로 반환
final class ImageManager {
    
    /// `ImageManager`의 전역 공유 인스턴스입니다.
    static let shared = ImageManager()
    
    /// 외부에서 인스턴스를 생성하지 못하도록 막는 초기화 메서드입니다.
    private init() {}

    /// 이미지를 JPEG 형식으로 파일로 저장하고, 저장된 파일의 경로를 반환합니다.
    ///
    /// - Parameters:
    ///   - image: 저장할 `UIImage` 객체입니다.
    ///   - name: 저장할 파일의 이름입니다. (예: `"image.jpg"`)
    ///
    /// - Returns: 저장에 성공하면 해당 파일의 경로(`String`)를 반환하고, 실패하면 `nil`을 반환합니다.
    func saveImage(_ image: UIImage, withName name: String) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            print("이미지를 JPEG 데이터로 변환 실패")
            return nil
        }

        let fileURL = getDocumentsDirectory().appendingPathComponent(name)

        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("이미지 저장 실패:", error)
            return nil
        }
    }

    /// 저장된 이미지 파일 경로를 통해 이미지를 불러옵니다.
    ///
    /// - Parameter path: 저장된 이미지 파일의 전체 경로입니다.
    ///
    /// - Returns: 경로에 해당하는 `UIImage` 객체를 반환하며, 파일이 존재하지 않거나 읽기에 실패한 경우 `nil`을 반환합니다.
    func loadImage(fromPath path: String) -> UIImage? {
        let fileURL = URL(fileURLWithPath: path)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("파일이 존재하지 않음:", fileURL.path)
            return nil
        }

        return UIImage(contentsOfFile: fileURL.path)
    }

    /// 앱의 도큐먼트 디렉토리 경로를 반환합니다.
    ///
    /// - Returns: 앱의 도큐먼트 디렉토리를 가리키는 `URL` 객체입니다.
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

