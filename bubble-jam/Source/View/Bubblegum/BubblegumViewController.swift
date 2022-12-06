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
    
    init(presenter: BubblegumPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var titleLabels: TitleLabels = {
        
        let labels = TitleLabels(nameOfChallenge: "Placeholder Jam", descriptionOfChallenge: "N Days Left")
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
        
        return samplerFrame
        
    }()
    
    @objc func frameFunc() {
        presenter.playAudio()
    }
    
    private lazy var samplePlayButton: SamplePlayButton = {
        
        let playButton = SamplePlayButton(frame: .zero, sizeOfButton: (sizeOfFrame * 0.4))
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        return playButton
        
    }()
    
    private lazy var draftPill: DraftPill = {
        let pill = DraftPill(frame: .zero)
        pill.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pillFunc))
        pill.isUserInteractionEnabled = true
        pill.addGestureRecognizer(tapGesture)
        
        return pill
        
    }()
    
    @objc func pillFunc() {
        showAlert(
            title: "Oops, this is not ready yet!",
            message: "We're still working on this feature, hang tight!"
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8862745098, blue: 0.9529411765, alpha: 1)
        buildLayout()
        presenter.initAudioDownload(in: nil)
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
        //
    }
    
    func setupHierarchy() {
//        view.addSubview(draftPill)
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
            
//            draftPill.topAnchor.constraint(equalTo: sampleFrame.bottomAnchor),
//            draftPill.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            draftPill.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            draftPill.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabels.heightAnchor.constraint(equalToConstant: 128)
        ])
        
    }
    
}
