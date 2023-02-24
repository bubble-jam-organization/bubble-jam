//
//  BubblegumViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

protocol BubblegumViewDelegate: AnyObject {
    func audioHasBeenLoaded()
    func startLoading()
    func audioIsPlaying(_ audio: Audio)
    func errorWhenLoadingAudio(title: String, description: String)
}

class BubblegumViewController: UIViewController, AlertPresentable {
    let sizeOfFrame: CGFloat = 300
    let presenter: BubblegumPresenting
    weak var managerDelegate: ManagerDelegate?
    
    private lazy var titleLabels: TitleLabels = {
        let labels = TitleLabels(nameOfChallenge: "Protojam", descriptionOfChallenge: "\(presenter.getDaysRemaining()) ")
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
        samplerFrame.clipsToBounds = true
        samplerFrame.isAccessibilityElement = true
        samplerFrame.accessibilityLabel = NSLocalizedString("Jam Button", comment: "Jam Button")
        samplerFrame.accessibilityTraits = .button
        samplerFrame.accessibilityHint = NSLocalizedString("Plays the jam", comment: "play jam")
        return samplerFrame
    }()
    
    private lazy var samplePlayButton: SamplePlayButton = {
        let playButton = SamplePlayButton(frame: .zero, sizeOfButton: (sizeOfFrame * 0.4))
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
        
    }()
    
    private lazy var draftPill: PillButtonComponent = {
        let pill = PillButtonComponent(frame: .zero)
        pill.pillLabel.text = NSLocalizedString("Start Drafting", comment: "Drafting button")
        pill.leftSideSymbol = UIImage(systemName: "music.mic.circle.fill")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pillFunc))
        pill.translatesAutoresizingMaskIntoConstraints = false
        pill.isUserInteractionEnabled = true
        pill.addGestureRecognizer(tapGesture)
        return pill
    }()
    
    private lazy var gumPacks: PacksTexture = {
        let image = PacksTexture(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init(presenter: BubblegumPresenting, managerDelegate: ManagerDelegate) {
        self.presenter = presenter
        self.managerDelegate = managerDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        presenter.initAudioDownload(in: nil)
    }
    
    @objc func frameFunc() {
        presenter.playAudio()
    }
    
    @objc func pillFunc() {
        self.managerDelegate?.scrollToBottom()
    }
}

extension BubblegumViewController: BubblegumViewDelegate {
    func audioIsPlaying(_ audio: Audio) {
        let sheet = InformationSheetViewController(audio: audio, presenter: presenter)
        let guide = view.safeAreaLayoutGuide
        let labels = CGFloat(titleLabels.frame.height)
        let height = guide.layoutFrame.size.height - labels
        sheet.sheetPresentationController?.detents = [ .custom { _ in return height } ]
        
        present(sheet, animated: true)
    }
    
    func startLoading() {
        print("Starting load")
    }
    
    func errorWhenLoadingAudio(title: String, description: String) {
        showAlert(title: title, message: description)
    }
    
    func audioHasBeenLoaded() {
        print("Hide loading")
    }
}

extension BubblegumViewController: ViewCoding {
    
    func setupView() {
        view.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(true, animated: true)
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
            sampleFrame.widthAnchor.constraint(greaterThanOrEqualToConstant: sizeOfFrame),
            sampleFrame.heightAnchor.constraint(greaterThanOrEqualToConstant: sizeOfFrame),
            sampleFrame.topAnchor.constraint(equalTo: titleLabels.bottomAnchor),
            
            samplePlayButton.centerXAnchor.constraint(equalTo: sampleFrame.centerXAnchor),
            samplePlayButton.centerYAnchor.constraint(equalTo: sampleFrame.centerYAnchor),
            samplePlayButton.widthAnchor.constraint(equalTo: samplePlayButton.widthAnchor),
            samplePlayButton.heightAnchor.constraint(equalTo: samplePlayButton.heightAnchor),
            
            draftPill.topAnchor.constraint(equalTo: sampleFrame.bottomAnchor),
            draftPill.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            draftPill.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabels.heightAnchor.constraint(equalToConstant: 134)
        ])
        
    }
    
}
