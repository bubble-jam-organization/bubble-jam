//
//  Presenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 23/11/22.
//

import Foundation

protocol PresenterProtocol {
    func handlePlayButton()
}

class Presenter: PresenterProtocol {
    func handlePlayButton() {
        print("HANDLING PLAY BUTTON!!!!")
    }
}
