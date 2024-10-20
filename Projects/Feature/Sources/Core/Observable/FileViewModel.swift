import Foundation
import SwiftUI
import PhotosUI
import DIContainer
import SwiftUtil
import Domain
import Combine

enum FileError: Error {
    case photoLoadTransferable
}

final class FileViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var fileRepo: FileRepo
    
    @Published var imageUploadFlow: Flow<File> = .idle
    @Published var imageFlow: Flow<Image> = .idle
}

extension FileViewModel {
    @MainActor
    public func uploadPhoto(photo: PhotosPickerItem) {
        Task {
            guard let data = try? await photo.loadTransferable(type: Data.self) else {
                imageUploadFlow = .failure(FileError.photoLoadTransferable)
                return
            }
            
            fileRepo.upload(type: .image, file: data)
                .map(\.data)
                .flow(\.imageUploadFlow, on: self)
                .silentSink()
                .store(in: &subscriptions)
        }
        Task {
            guard let image = try? await photo.loadTransferable(type: Image.self) else {
                imageFlow = .failure(FileError.photoLoadTransferable)
                return
            }
            
            self.imageFlow = .success(image)
        }
    }
}
