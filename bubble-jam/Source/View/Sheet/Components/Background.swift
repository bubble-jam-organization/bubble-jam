//
//  Background.swift
//  bubble-jam
//
//  Created by Caio Soares on 30/11/22.
//

import UIKit

class Background: UIImageView {

    private lazy var backgroundTexture: UIImageView = {
        
        let texture = UIImageView(frame: .zero)
        texture.image = UIImage(named: "Sheet")
        texture.translatesAutoresizingMaskIntoConstraints = false
        texture.contentMode = .scaleToFill
        texture.clipsToBounds = true
        
        return texture
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Background: ViewCoding {
    func setupView() {
        
    }
    
    func setupHierarchy() {
        self.addSubview(backgroundTexture)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundTexture.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundTexture.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundTexture.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundTexture.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
