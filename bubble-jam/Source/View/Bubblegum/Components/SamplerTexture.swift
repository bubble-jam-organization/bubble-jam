//
//  SampleTexture.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

class SampleTexture: UIImageView {
    
    var sizeOfCircle: CGFloat?

    private lazy var samplerTexture: UIImageView = {
        
        let texture = UIImageView(frame: .zero)
        texture.image = UIImage(named: "Bubblegum")
        texture.translatesAutoresizingMaskIntoConstraints = false
        texture.contentMode = .scaleAspectFit
        texture.clipsToBounds = true
        
        return texture
        
    }()
    
    init(frame: CGRect, sizeOfCircle: CGFloat) {
        super.init(frame: .zero)
        self.sizeOfCircle = sizeOfCircle
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SampleTexture: ViewCoding {
    func setupView() {
        //
    }
    
    func setupHierarchy() {
        self.addSubview(samplerTexture)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            samplerTexture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            samplerTexture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            samplerTexture.widthAnchor.constraint(equalToConstant: sizeOfCircle!),
            samplerTexture.heightAnchor.constraint(equalToConstant: sizeOfCircle!)
        ])
    }
}
