//
//  AudioInformationGroup.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import UIKit

class AudioInformationGroup: UIView {
    
    var audioDetails: AudioDetails
    
    private lazy var audioLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.font = UIFont.preferredFont(for: .title2, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var audioDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = audioDetails.description
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var audioBPM: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(audioDetails.bpm) + " bpm"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.font = UIFont.preferredFont(for: .title3, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var audioNotes: UILabel = {
        let notes = UILabel(frame: .zero)
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.text = "E G D B F#"
        notes.textColor = .white
        notes.font = UIFont.systemFont(ofSize: 18)
        notes.font = UIFont.preferredFont(for: .title3, weight: .regular)
        notes.adjustsFontForContentSizeCategory = true
        return notes
    }()
    
    init(frame: CGRect, audioDetails: AudioDetails) {
        self.audioDetails = audioDetails
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AudioInformationGroup: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(audioLabel)
        self.addSubview(audioDescription)
        self.addSubview(audioBPM)
        self.addSubview(audioNotes)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            audioDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            audioDescription.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            audioDescription.widthAnchor.constraint(equalTo: self.widthAnchor),
            audioLabel.bottomAnchor.constraint(equalTo: audioDescription.topAnchor, constant: -4),
 
            audioBPM.topAnchor.constraint(equalTo: audioDescription.bottomAnchor, constant: 12),
            
            audioNotes.topAnchor.constraint(equalTo: audioBPM.bottomAnchor, constant: 4)
        ])
    }
    
}
