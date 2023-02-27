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
                            bpm: Int(challenge.audio.bpm)
                        )
        )
        group.translatesAutoresizingMaskIntoConstraints = false
        return group
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let background = Background(frame: .zero)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
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
    
    @objc func downloadFunc() {
        let filePath = challenge.audio.path
        let newPath = filePath.appendingPathExtension(challenge.audio.format.rawValue)
        do {
            try FileManager.default.copyItem(at: filePath, to: newPath)
            let activityView = UIActivityViewController(activityItems: [newPath], applicationActivities: nil)
            activityView.excludedActivityTypes = [.markupAsPDF, .assignToContact]
            show(activityView, sender: self)
        } catch {
            showAlert(title: "Erro", message: "Não foi possível exportar o áudio devido a um erro desconhecido.")
        }
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
        view.addSubview(information)
        view.addSubview(downloadBox)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            challengeBanner.topAnchor.constraint(equalTo: view.topAnchor),
            challengeBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            challengeBanner.widthAnchor.constraint(equalTo: view.widthAnchor),
            challengeBanner.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.width * 0.5625)),
            
            information.topAnchor.constraint(equalTo: challengeBanner.bottomAnchor, constant: 14),
            information.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            information.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
//            downloadBox.topAnchor.constraint(equalTo: sampleFrame.bottomAnchor),
            downloadBox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            downloadBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadBox.heightAnchor.constraint(equalToConstant: 90),
            downloadBox.widthAnchor.constraint(equalToConstant: 185)
        ])
    }
     
}
