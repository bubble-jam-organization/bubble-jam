//
//  MicButton.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 15/02/23.
//

import UIKit

class MicButton: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var micImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "MIC"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var jamButton: PillButtonComponent = {
        let pill = PillButtonComponent(frame: .zero)
        pill.translatesAutoresizingMaskIntoConstraints = false
        pill.pillLabel.text = "Adicionar Jam"
        pill.radius = 32
        pill.contentHorizontalAlignment = .center
        return pill
    }()
    
}

extension MicButton: ViewCoding {
    func setupHierarchy() {
        self.addSubview(micImage)
        self.addSubview(jamButton)
    }
    
    func setupConstraints() {
        let micConstraints = [
            micImage.topAnchor.constraint(equalTo: self.topAnchor),
            micImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            micImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            micImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        let jamButtonConstraints = [
            jamButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            jamButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            jamButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(micConstraints)
        NSLayoutConstraint.activate(jamButtonConstraints)
    }
}