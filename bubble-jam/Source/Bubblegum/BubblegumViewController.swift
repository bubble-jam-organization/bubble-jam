//
//  BubblegumViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

class BubblegumViewController: UIViewController {
    
    let sizeOfFrame: CGFloat = 300
    
    private lazy var sampleFrame: SamplePlayerFrame = {
       
        let samplerFrame = SamplePlayerFrame(frame: .zero, sizeOfFrame: sizeOfFrame)
        samplerFrame.translatesAutoresizingMaskIntoConstraints = false
        return samplerFrame
        
    }()
    
    private lazy var samplerPlayButton: SamplerPlayButton = {
        
        let playButton = SamplerPlayButton(frame: .zero, sizeOfButton: (sizeOfFrame * 0.4))
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8862745098, blue: 0.9529411765, alpha: 1)
        buildLayout()
    }

}

extension BubblegumViewController: ViewCoding {
    
    func setupView() {
        //
    }
    
    func setupHierarchy() {
        view.addSubview(sampleFrame)
        sampleFrame.addSubview(samplerPlayButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sampleFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleFrame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sampleFrame.widthAnchor.constraint(equalTo: sampleFrame.widthAnchor),
            sampleFrame.heightAnchor.constraint(equalTo: sampleFrame.heightAnchor),
            
            samplerPlayButton.centerXAnchor.constraint(equalTo: sampleFrame.centerXAnchor),
            samplerPlayButton.centerYAnchor.constraint(equalTo: sampleFrame.centerYAnchor),
            samplerPlayButton.widthAnchor.constraint(equalTo: samplerPlayButton.widthAnchor),
            samplerPlayButton.heightAnchor.constraint(equalTo: samplerPlayButton.heightAnchor),
        ])
    }
    
}
