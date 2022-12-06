//
//  PlayerProgressBar.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 06/12/22.
//

import UIKit

class PlayerProgressBar: UIView {
    private let frameSize = 64.0
    
    private lazy var sampleFrame: SamplePlayerFrame = {
        let samplerFrame = SamplePlayerFrame(frame: .zero, sizeOfFrame: frameSize)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(frameTapped))
        samplerFrame.translatesAutoresizingMaskIntoConstraints = false
        samplerFrame.isUserInteractionEnabled = true
        samplerFrame.isMultipleTouchEnabled = true
        samplerFrame.clipsToBounds = true
        samplerFrame.addGestureRecognizer(tapGesture)
        return samplerFrame
    }()
    
    private lazy var samplePlayButton: SamplePlayButton = {
        let playButton = SamplePlayButton(frame: .zero, sizeOfButton: (frameSize * 0.4))
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private lazy var progressBar: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = .white
        slider.addTarget(self, action: #selector(didSlide), for: .allEvents)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didSlide(sender: Any) {
        guard let sender = sender as? UISlider else { return }
    }
    
    @objc func frameTapped() {
        print("Player tapped")
    }
}

extension PlayerProgressBar: ViewCoding {
    func setupView() {
        
    }
    
    func setupHierarchy() {
        self.addSubview(sampleFrame)
        self.addSubview(samplePlayButton)
        self.addSubview(progressBar)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sampleFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            sampleFrame.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sampleFrame.widthAnchor.constraint(equalToConstant: 64),
            sampleFrame.heightAnchor.constraint(equalToConstant: 64),
            
            samplePlayButton.centerXAnchor.constraint(equalTo: sampleFrame.centerXAnchor),
            samplePlayButton.centerYAnchor.constraint(equalTo: sampleFrame.centerYAnchor),
            samplePlayButton.widthAnchor.constraint(equalToConstant: 6),
            samplePlayButton.heightAnchor.constraint(equalToConstant: 6),
            
            progressBar.leadingAnchor.constraint(equalTo: sampleFrame.trailingAnchor, constant: 12),
            progressBar.centerYAnchor.constraint(equalTo: sampleFrame.centerYAnchor),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}
