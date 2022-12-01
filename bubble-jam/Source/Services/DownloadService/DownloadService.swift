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
    
    func fetchAudio(audioName: String, audioExtension: String, folderPath: String = "bubblejam.tmp") throws {
        guard let audioURL = bundle.url(forResource: audioName, withExtension: audioExtension) else {
            throw DownloadServiceError.fileNotExists
        }
        
        let documentsDirectoryURL = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let tmpPath = documentsDirectoryURL.appendingPathComponent(folderPath)
        
        try createFolder(path: tmpPath)
        
        let destinationURL = tmpPath.appending(path: audioURL.lastPathComponent)
        if manager.fileExists(atPath: destinationURL.path()) { throw DownloadServiceError.fileAlreadyExists }

        try manager.copyItem(at: audioURL, to: destinationURL)

    }
    
    private func createFolder(path: URL) throws {
        if !manager.fileExists(atPath: path.path()) {
            try manager.createDirectory(at: path, withIntermediateDirectories: true)
        }

    }
    
}
