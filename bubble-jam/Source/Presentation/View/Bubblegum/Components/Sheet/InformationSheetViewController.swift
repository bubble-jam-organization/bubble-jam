//
//  SheetViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 30/11/22.
//

import UIKit
import AVFoundation

class InformationSheetViewController: UIViewController, AlertPresentable {
    let presenter: BubblegumPresenting
    let challenge: Challenge
    var activityQueue: [URL] = []
    var isPlaying: Bool = false
    
    init(challenge: Challenge, presenter: BubblegumPresenting) {
        self.presenter = presenter
        self.challenge = challenge
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit { presenter.stopAudio() }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var information: UIView = {
        let group = AudioInformationGroup(
            frame: .zero,
            audioDetails: AudioDetails(
                notes: challenge.audio.notes,
                description: challenge.description,
                rules: challenge.rules,
                bpm: Int(challenge.audio.bpm)
            )
        )
        group.translatesAutoresizingMaskIntoConstraints = false
        return group
    }()
    
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let background = Background(frame: .zero)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "AppButton"), for: .normal)
        button.addTarget(self, action: #selector(toggleAudio), for: .touchUpInside)
        button.setTitle("Play", for: .normal)
        return button
    }()
    
    private lazy var challengeBanner: UIImageView = {
        let banner = ChallengeBanner(frame: .zero)
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.layer.cornerRadius = 50
        banner.image = downloadBannerImage(challenge.banner)
        return banner
    }()
    
    private lazy var downloadBox: DownloadButton = {
        let box = DownloadButton(frame: .zero)
        box.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(downloadFunc))
        box.isUserInteractionEnabled = true
        box.addGestureRecognizer(tapGesture)
        return box
    }()
    
    private lazy var playerBar: CustomPlayer = {
        let customPlayer = CustomPlayer(frame: .zero, player: presenter.player)
        customPlayer.translatesAutoresizingMaskIntoConstraints = false
        customPlayer.playButtonTapped = presenter.forcePlayAudio
        customPlayer.pauseButtonTapepd = presenter.pauseAudio
        return customPlayer
    }()
    
    @objc func downloadFunc() {
        let filePath = challenge.audio.path
        let newPath = filePath.appendingPathExtension(challenge.audio.format.rawValue)
        do {
            let manager = FileManager.default
            if !manager.fileExists(atPath: newPath.path()) { try manager.copyItem(at: filePath, to: newPath) }
            let activityView = UIActivityViewController(activityItems: [newPath], applicationActivities: nil)
            activityView.excludedActivityTypes = [.markupAsPDF, .assignToContact]
            show(activityView, sender: self)
        } catch {
            showAlert(title: "Erro", message: "Não foi possível exportar o áudio devido a um erro desconhecido.")
        }
    }
    
    @objc func toggleAudio() {
        if isPlaying {
            presenter.forcePlayAudio()
        } else {
            presenter.stopAudio()
        }
        isPlaying.toggle()
    }
    
    func downloadBannerImage(_ url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
}

extension InformationSheetViewController: ViewCoding {
    func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(challengeBanner)
        view.addSubview(playerBar)
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(information)
        verticalStack.addArrangedSubview(downloadBox)
        if UIAccessibility.isVoiceOverRunning { view.addSubview(playButton) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            challengeBanner.topAnchor.constraint(equalTo: view.topAnchor),
            challengeBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            challengeBanner.widthAnchor.constraint(equalTo: view.widthAnchor),
            challengeBanner.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.width * 0.5625)),
            
            playerBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -8),
            playerBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            playerBar.topAnchor.constraint(equalTo: challengeBanner.bottomAnchor, constant: 10),
            playerBar.heightAnchor.constraint(equalToConstant: 60),

            scrollView.topAnchor.constraint(equalTo: playerBar.bottomAnchor, constant: 14),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            verticalStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        if UIAccessibility.isVoiceOverRunning {
            NSLayoutConstraint.activate([
                playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                playButton.centerXAnchor.constraint(equalTo: challengeBanner.centerXAnchor),
                playButton.widthAnchor.constraint(equalToConstant: 150),
                playButton.heightAnchor.constraint(equalToConstant: 150)
            
            ])
        }
    }
     
}
