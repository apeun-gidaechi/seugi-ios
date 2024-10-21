import Foundation
import SwiftUI
import PhotosUI
import DIContainer
import SwiftUtil
import Domain
import Combine

enum FileError: Error {
    case photoLoadTransferable
    case notFoundFile
}

final class FileViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var fileRepo: FileRepo
    
    @Published var imageUploadFlow: Flow<File> = .idle
    @Published var imageFlow: Flow<Image> = .idle
    
    @Published var fileUploadFlow: Flow<File> = .idle
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
    
    public func uploadFile(url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            fileUploadFlow = .failure(FileError.notFoundFile)
            return
        }
        
        defer {
            url.stopAccessingSecurityScopedResource()
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            fileRepo.upload(type: .file, file: data)
                .map(\.data)
                .flow(\.fileUploadFlow, on: self)
                .silentSink()
                .store(in: &subscriptions)
        } catch {
            fileUploadFlow = .failure(FileError.notFoundFile)
            print(error)
        }
    }
}
