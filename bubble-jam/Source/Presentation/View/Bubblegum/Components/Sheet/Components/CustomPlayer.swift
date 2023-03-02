//
//  CustomPlayer.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 02/03/23.
//

import UIKit

class CustomPlayer: UIView {
    var isPlaying = false {
        didSet {
            if isPlaying {
                playButtonTapped?()
                buttonIcon.image = UIImage(systemName: "pause.fill")
                return
            }
            pauseButtonTapepd?()
            buttonIcon.image = UIImage(systemName: "play.fill")
        }
    }
    
    var duration: String? { didSet { audioDuration.text = duration } }
    var playButtonTapped: (() -> Void)?
    var pauseButtonTapepd: (() -> Void)?

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AppButtonFrame"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(toggleState), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let audioDuration: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.preferredFont(for: .caption1, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "play.fill")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let progressBar: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.setThumbImage(UIImage(), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    @objc func toggleState() { isPlaying.toggle() }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension CustomPlayer: ViewCoding {
    func setupHierarchy() {
        self.addSubview(playButton)
        self.addSubview(buttonIcon)
        self.addSubview(progressBar)
        self.addSubview(audioDuration)
    }
    
    func setupConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let buttonIconConstraints = [
            buttonIcon.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            buttonIcon.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            buttonIcon.heightAnchor.constraint(equalTo: playButton.heightAnchor, multiplier: 0.2),
            buttonIcon.widthAnchor.constraint(equalTo: playButton.widthAnchor, multiplier: 0.2)
        ]
        
        let progressBarConstraints = [
            progressBar.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: playButton.trailingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ]
        
        let audioDurationConstraints = [
            audioDuration.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 10),
            audioDuration.leadingAnchor.constraint(equalTo: playButton.trailingAnchor),
            audioDuration.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(buttonIconConstraints)
        NSLayoutConstraint.activate(progressBarConstraints)
        NSLayoutConstraint.activate(audioDurationConstraints)
    }
}
