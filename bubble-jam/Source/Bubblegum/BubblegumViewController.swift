//
//  BubblegumViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

class BubblegumViewController: UIViewController {
    
    let sizeOfFrame: CGFloat = 300
    
    private lazy var titleLabels: TitleLabels = {
        
        let labels = TitleLabels(nameOfChallenge: "Smiling Friends Jam", descriptionOfChallenge: "its smormu")
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
        
    }()
    
    private lazy var sampleFrame: SamplePlayerFrame = {
       
        let samplerFrame = SamplePlayerFrame(frame: .zero, sizeOfFrame: sizeOfFrame)
        samplerFrame.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(frameFunc)
        )
        samplerFrame.isUserInteractionEnabled = true
        samplerFrame.isMultipleTouchEnabled = true
        samplerFrame.addGestureRecognizer(tapGesture)
        
        return samplerFrame
        
    }()
    
    @objc func frameFunc() {
        print("frame was tapped")
    }
    
    private lazy var samplePlayButton: SamplePlayButton = {
        
        let playButton = SamplePlayButton(frame: .zero, sizeOfButton: (sizeOfFrame * 0.4))
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        return playButton
        
    }()
    
    private lazy var draftPill: DraftPill = {
        
        let pill = DraftPill(frame: .zero)
        pill.translatesAutoresizingMaskIntoConstraints = false
        return pill
        
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
        view.addSubview(draftPill)
        view.addSubview(sampleFrame)
        view.addSubview(titleLabels)
        sampleFrame.addSubview(samplePlayButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sampleFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleFrame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sampleFrame.widthAnchor.constraint(equalToConstant: sizeOfFrame),
            sampleFrame.heightAnchor.constraint(equalToConstant: sizeOfFrame),
            
            samplePlayButton.centerXAnchor.constraint(equalTo: sampleFrame.centerXAnchor),
            samplePlayButton.centerYAnchor.constraint(equalTo: sampleFrame.centerYAnchor),
            samplePlayButton.widthAnchor.constraint(equalTo: samplePlayButton.widthAnchor),
            samplePlayButton.heightAnchor.constraint(equalTo: samplePlayButton.heightAnchor),
            
            draftPill.topAnchor.constraint(equalTo: sampleFrame.bottomAnchor),
            draftPill.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            draftPill.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            draftPill.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabels.bottomAnchor.constraint(equalTo: sampleFrame.topAnchor)
        ])
        
    }
    
}
