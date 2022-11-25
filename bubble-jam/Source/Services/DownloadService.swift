//
//  ShareService.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 25/11/22.
//

import Foundation

struct DownloadService {
    
    private var manager: FileManager
    private var bundle: Bundle
    
    init(manager: FileManager = FileManager.default, bundle: Bundle = Bundle.main) {
        self.manager = manager
        self.bundle = bundle
    }
    
    
    func downloadAudio(audioName: String, audioExtension: String, completionHandler: @escaping (Result<URL, Error>) -> Void) {
        guard let audioURL = bundle.url(forResource: audioName, withExtension: audioExtension) else {
            completionHandler(.failure(DownloadServiceError.fileNotExists))
            return
        }
        
        let documentsDirectoryURL = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectoryURL.appending(path: audioURL.lastPathComponent)
        
        if manager.fileExists(atPath: destinationURL.path()) {
            completionHandler(.failure(DownloadServiceError.fileAlreadyExists))
            return
        }
        
        do {
            try manager.copyItem(at: audioURL, to: destinationURL)
            completionHandler(.success(destinationURL))
        } catch {
            completionHandler(.failure(DownloadServiceError.unableToDownloadItem(error.localizedDescription)))
        }
        
    }
    
}
