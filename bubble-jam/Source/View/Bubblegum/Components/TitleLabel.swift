//
//  TitleLabels.swift
//  bubble-jam
//
//  Created by Caio Soares on 25/11/22.
//

import UIKit

class TitleLabels: UIView {
    
    var nameOfChallenge: String?
    var descriptionOfChallenge: String?

    private lazy var nameOfChallengeLabel: UILabel = {
        
        // TODO: Adicionar outline pra essa ***** de label.
        
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        label.text = nameOfChallenge
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
        
    }()
    
    private lazy var descriptionOfChallengeLabel: UILabel = {
        
        let label = UILabel()
        label.text = descriptionOfChallenge
        label.textColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
        
    }()
    
    init(nameOfChallenge: String, descriptionOfChallenge: String) {
        self.nameOfChallenge = nameOfChallenge
        self.descriptionOfChallenge = descriptionOfChallenge
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TitleLabels: ViewCoding {
    func setupView() {
        //
    }
    
    func setupHierarchy() {
        self.addSubview(nameOfChallengeLabel)
        self.addSubview(descriptionOfChallengeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameOfChallengeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameOfChallengeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameOfChallengeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            nameOfChallengeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            nameOfChallengeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            
            descriptionOfChallengeLabel.topAnchor.constraint(equalTo: nameOfChallengeLabel.bottomAnchor),
            descriptionOfChallengeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
