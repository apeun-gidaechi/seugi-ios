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

public final class FileManager: BaseViewModel<FileManager.Effect> {
    public enum Effect {}
    
    @Inject private var fileRepo: any FileRepo
    
    public func uploadPhoto(photo: PhotosPickerItem, completion: @escaping (_ url: String) -> Void, failure: @escaping (APIError) -> Void) {
        photo.loadTransferable(type: Data.self) { [self] result in
            switch result {
            case .success(let data):
                guard let data else {
                    failure(.unknown)
                    return
                }
                fileRepo.upload(type: .image, file: data)
                    .map(\.data)
                    .sink {
                        if case .failure(let error) = $0 {
                            failure(error)
                        }
                    } receiveValue: {
                        completion($0)
                    }
                    .store(in: &subscriptions)
            case .failure:
                failure(.unknown)
            }
        }
    }
}
