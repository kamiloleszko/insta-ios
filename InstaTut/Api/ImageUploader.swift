//
//  ImageUploader.swift
//  InstaTut
//
//  Created by kamil on 12/06/2022.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) {metadata, error in
            if let error = error {
                print("DEBUG: FAILED to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL{ (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}


