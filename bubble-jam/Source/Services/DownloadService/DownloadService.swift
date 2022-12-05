//
//  ShareService.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 25/11/22.
//

import Foundation

struct DownloadService: DownloadServicing {
    private var manager: FileManager
    private var bundle: Bundle
    private var folderPath: String
    
    init(manager: FileManager = FileManager.default, bundle: Bundle = Bundle.main, folderPath: String = "bubblejam.tmp") {
        self.manager = manager
        self.bundle = bundle
        self.folderPath = folderPath
    }
    
    func downloadAudio(audioName: String, audioExtension: String) throws {
        let audioUrl = try loadAudioUrl(audioName, audioExtension)
        let tmpPath = loadTmpPathUrl()
        let destinationUrl = tmpPath.appending(path: audioUrl.lastPathComponent)
        
        try createFolder(path: tmpPath)
        if manager.fileExists(atPath: destinationUrl.path()) { throw DownloadServiceError.fileAlreadyExists }
        try manager.copyItem(at: audioUrl, to: destinationUrl)
    }
    
    func loadSandboxAudio() throws -> Audio {
        let tmpPath = loadTmpPathUrl()
        if manager.fileExists(atPath: tmpPath.path()) {
            let audioName = try manager.contentsOfDirectory(atPath: tmpPath.path()).first!
            let path = tmpPath.appending(path: audioName)
            guard let contents = manager.contents(atPath: path.path()) else {
                throw DownloadServiceError.fileNotExists
            }
            let audioComponents = audioName.components(separatedBy: ".")
            return Audio(
                data: contents,
                localAudioName: audioComponents[0],
                format: AudioFormat.init(rawValue: audioComponents[1]),
                details: AudioDetails(notes: [], description: "Lorem ipsum", bpm: 0)
            )
        }
        throw DownloadServiceError.fileNotExists
    }
    
    private func loadAudioUrl(_ name: String, _ format: String) throws -> URL {
        guard let url = bundle.url(forResource: name, withExtension: format) else {
            throw DownloadServiceError.fileNotExists
        }
        return url
    }
    
    private func loadTmpPathUrl() -> URL {
        let documentsDirectoryURL = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let tmpPath = documentsDirectoryURL.appendingPathComponent(self.folderPath)
        return tmpPath
    }
    
    private func createFolder(path: URL) throws {
        if !manager.fileExists(atPath: path.path()) {
            try manager.createDirectory(at: path, withIntermediateDirectories: true)
        }

    }
    
}
