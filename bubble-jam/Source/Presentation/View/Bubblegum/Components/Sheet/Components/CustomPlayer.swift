//
//  CustomPlayer.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 02/03/23.
//

import UIKit
import AVFAudio

class CustomPlayer: UIView {
    var playButtonTapped: (() -> Void)?
    var pauseButtonTapepd: (() -> Void)?
    var player: AVAudioPlayer
    private var displayLink: CADisplayLink?

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
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var progressBar: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.5960784314, alpha: 0.5)
        slider.setThumbImage(UIImage(), for: .normal)
        slider.thumbTintColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        slider.isContinuous = false
        slider.addTarget(self, action: #selector(didBeginDraggingSlider), for: .touchDown)
        slider.addTarget(self, action: #selector(didEndDraggingSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    @objc func updateProgress() {
        let currentDuration = player.duration - player.currentTime
        let playbackProgress = Float(player.currentTime / player.duration)
        updatePlayerDuration(currentDuration)
        progressBar.setValue(playbackProgress, animated: true)
    }
    
    @objc func didBeginDraggingSlider() {
        displayLink?.isPaused = true
    }

    @objc func didEndDraggingSlider() {
        let newPosition = player.duration * Double(progressBar.value)
        let newDuration = player.duration - player.currentTime
        updatePlayerDuration(newDuration)
        player.currentTime = newPosition
        displayLink?.isPaused = false
    }
    
    func startUpdatingPlaybackStatus() {
         displayLink = CADisplayLink(target: self, selector: #selector(updateProgress))
         displayLink!.add(to: .main, forMode: .common)
     }

     func stopUpdatingPlaybackStatus() {
         displayLink?.invalidate()
     }

    func updatePlayerDuration(_ value: TimeInterval) {
        let date = Date(timeIntervalSinceReferenceDate: value)
        let format = DateFormatter()
        format.dateFormat = "mm:ss"
        audioDuration.text = format.string(from: date)
    }
    
    func clearPlayer() {
        displayLink?.invalidate()
        displayLink = nil
        buttonIcon.image = UIImage(systemName: "play.fill")
        player.stop()
    }
    
    @objc func toggleState() {
        if player.isPlaying {
            pauseButtonTapepd?()
            stopUpdatingPlaybackStatus()
            buttonIcon.image = UIImage(systemName: "play.fill")
            return
        }
        playButtonTapped?()
        startUpdatingPlaybackStatus()
        buttonIcon.image = UIImage(systemName: "pause.fill")
    }
    
    init(frame: CGRect, player: AVAudioPlayer) {
        self.player = player
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePlayerDuration(player.duration)
        startUpdatingPlaybackStatus()
        buttonIcon.image = UIImage(systemName: player.isPlaying ? "pause.fill" : "play.fill")
        player.delegate = self
    }
}

extension CustomPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        clearPlayer()
    }
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
            audioDuration.topAnchor.constraint(equalTo: progressBar.bottomAnchor),
            audioDuration.leadingAnchor.constraint(equalTo: playButton.trailingAnchor),
            audioDuration.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(buttonIconConstraints)
        NSLayoutConstraint.activate(progressBarConstraints)
        NSLayoutConstraint.activate(audioDurationConstraints)
    }
}
