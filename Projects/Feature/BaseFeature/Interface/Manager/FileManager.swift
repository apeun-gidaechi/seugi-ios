//
//  FileManager.swift
//  BaseFeatureInterface
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import SwiftUI
import PhotosUI
import DIContainer
import Domain

public final class SeugiFileManager: BaseViewModel<SeugiFileManager.Subject> {
    public enum Subject {}
    
    @Inject private var fileRepo: any FileRepo
    
    public func uploadPhoto(photo: PhotosPickerItem, completion: @escaping (_ url: String) -> Void, failure: @escaping (APIError) -> Void) {
        photo.loadTransferable(type: Data.self) { [self] result in
            switch result {
            case .success(let data):
                guard let data else {
                    failure(.unknown)
                    return
                }
                sub(fileRepo.upload(type: .image, file: data)) {
                } success: { response in
                    completion(response.data)
                } failure: { error in
                    failure(error)
                }
            case .failure:
                failure(.unknown)
            }
        }
    }
}
