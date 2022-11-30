//
//  ChallengeBanner.swift
//  bubble-jam
//
//  Created by Caio Soares on 30/11/22.
//

import UIKit

class ChallengeBanner: UIImageView {

    private lazy var banner: UIImageView = {
        
        let banner = UIImageView(frame: .zero)
        banner.image = UIImage(named: "placeholderBanner")
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.contentMode = .scaleToFill
        
        return banner
        
    }()
    
    private lazy var inprintTexture: UIImageView = {
        
        let texture = UIImageView(frame: .zero)
        texture.image = UIImage(named: "Inprint")
        texture.translatesAutoresizingMaskIntoConstraints = false
        texture.contentMode = .scaleAspectFit
        texture.clipsToBounds = true
        texture.layer.opacity = 0.75
        
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

extension ChallengeBanner: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(banner)
        self.addSubview(inprintTexture)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: self.topAnchor),
            banner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            banner.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            inprintTexture.topAnchor.constraint(equalTo: self.topAnchor),
            inprintTexture.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            inprintTexture.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
}
