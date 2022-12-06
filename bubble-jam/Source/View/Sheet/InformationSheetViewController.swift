//
//  SheetViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 30/11/22.
//

import UIKit

class InformationSheetViewController: UIViewController, AlertPresentable {
    let audio: Audio
    let presenter: BubblegumPresenting
    var activityQueue: [URL] = []
    
    init(audio: Audio, presenter: BubblegumPresenting) {
        self.audio = audio
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit { presenter.pauseAudio() }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var information: UIView = {
        let group = AudioInformationGroup(frame: .zero, audioDetails: audio.details)
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
    
    private lazy var activityView: UIActivityViewController = {
        let activityView = UIActivityViewController(activityItems: activityQueue, applicationActivities: nil)
        activityView.excludedActivityTypes = [.markupAsPDF, .assignToContact]
        
        return activityView
    }()
    
    @objc func downloadFunc() {
        let audioPath = presenter.getAudioUrl().appending(path: "\(audio.localAudioName).\(audio.format.rawValue)")
        activityQueue.append(audioPath)
        show(activityView, sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension InformationSheetViewController: ViewCoding {
    func setupView() {
        
    }
    
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
            
            information.topAnchor.constraint(equalTo: challengeBanner.bottomAnchor),
            information.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            information.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 12),
            
//            downloadBox.topAnchor.constraint(equalTo: sampleFrame.bottomAnchor),
            downloadBox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            downloadBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadBox.heightAnchor.constraint(equalToConstant: 90),
            downloadBox.widthAnchor.constraint(equalToConstant: 185)
        ])
    }
     
}
