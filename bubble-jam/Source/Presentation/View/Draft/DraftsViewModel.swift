//
//  DraftsViewModel.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 16/02/23.
//

import Foundation

struct DraftViewModel {
    let audioPath: URL
    let audioName: String
    let audioDuration: String
    
    
    
}
#if DEBUG
extension DraftViewModel {
    static let bundle = Bundle.main
    static let mock = [
        DraftViewModel(audioPath: bundle.url(forResource: "song", withExtension: "m4a")!, audioName: "musica", audioDuration: "5:00"),
        DraftViewModel(audioPath: bundle.url(forResource: "song", withExtension: "m4a")!, audioName: "musica", audioDuration: "5:00"),
        DraftViewModel(
            audioPath: bundle.url(forResource: "song", withExtension: "m4a")!,
            audioName: "musicaaaadasdkasodpjasojasidjaoidjasodoiasjdoiasjdioasjdoasjodiajoidjasoidjasoi",
            audioDuration: "5:00"
        ),
        DraftViewModel(audioPath: bundle.url(forResource: "song", withExtension: "m4a")!, audioName: "musica", audioDuration: "5:00"),
        DraftViewModel(audioPath: bundle.url(forResource: "song", withExtension: "m4a")!, audioName: "musica", audioDuration: "5:00"),
    ]
}
#endif
