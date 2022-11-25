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
    
    func downloadAudio(audioName: String, audioExtension: String) throws {
        guard let audioURL = bundle.url(forResource: audioName, withExtension: audioExtension) else {
            throw DownloadServiceError.fileNotExists
        }
        
        let documentsDirectoryURL = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectoryURL.appending(path: audioURL.lastPathComponent)
        
        if manager.fileExists(atPath: destinationURL.path()) { throw DownloadServiceError.fileAlreadyExists }
        
        do {
            try manager.copyItem(at: audioURL, to: destinationURL)
        } catch {
           throw DownloadServiceError.unableToDownloadItem(error.localizedDescription)
        }
        
    }
    
}
