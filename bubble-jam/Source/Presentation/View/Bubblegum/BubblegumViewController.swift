//
//  BubblegumViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

protocol BubblegumViewDelegate: AnyObject {
    func showChallenge(title: String, daysLeft: String)
    func startLoading()
    func audioIsPlaying(challenge: Challenge)
    func errorWhenLoadingChallenge(title: String, description: String)
}

class BubblegumViewController: UIViewController, AlertPresentable {
    let sizeOfFrame: CGFloat = 300
    let presenter: BubblegumPresenting
    weak var managerDelegate: ManagerDelegate?
    
    private var titleLabels: TitleLabels = {
        let labels = TitleLabels()
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.color = .black
        return loadingIndicator
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
        pill.accessibilityLabel = NSLocalizedString("Start Drafting", comment: "Start Drafting")
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
        Task { await presenter.initChallengeDownload() }
    }
    
    @objc func frameFunc() {
        presenter.playAudio()

    }
    
    @objc func pillFunc() {
        self.managerDelegate?.scrollToBottom()
    }
}

extension BubblegumViewController: BubblegumViewDelegate {
    func errorWhenLoadingChallenge(title: String, description: String) {
        showAlert(title: title, message: description)
    }
    
    func audioIsPlaying(challenge: Challenge) {
        if UIAccessibility.isVoiceOverRunning {
            presenter.stopAudio()
        }
        let sheet = InformationSheetViewController(challenge: challenge, presenter: presenter)
        let guide = view.safeAreaLayoutGuide
        let labels = CGFloat(titleLabels.frame.height)
        let height = guide.layoutFrame.size.height - labels
        sheet.sheetPresentationController?.detents = [ .custom { _ in return height } ]
        present(sheet, animated: true)
    }
    
    func showChallenge(title: String, daysLeft: String) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.titleLabels.nameOfChallenge = title
            self?.titleLabels.descriptionOfChallenge = daysLeft
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.startAnimating()
        }
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
        view.addSubview(loadingIndicator)
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
            
            draftPill.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            draftPill.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            draftPill.heightAnchor.constraint(greaterThanOrEqualToConstant: draftPill.horizontalStack.layer.cornerRadius * 3),
            
            titleLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabels.heightAnchor.constraint(equalToConstant: 134),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
}
