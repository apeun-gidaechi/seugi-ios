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

public final class FileViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var fileRepo: any FileRepo
    
    @Published var fileFlow: Flow<File> = .idle
}

extension FileViewModel {
    @MainActor
    public func uploadPhoto(photo: PhotosPickerItem) async {
        guard let data = try? await photo.loadTransferable(type: Data.self) else {
            fileFlow = .failure(FileError.photoLoadTransferable)
            return
        }
        
        fileRepo.upload(type: .image, file: data)
            .map(\.data)
            .flow(\.fileFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
