//
//  PacksTexture.swift
//  bubble-jam
//
//  Created by Caio Soares on 05/12/22.
//

import UIKit

class PacksTexture: UIView {
    
    private lazy var gums: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "Packs")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.opacity = 0.7
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PacksTexture: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(gums)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gums.topAnchor.constraint(equalTo: self.topAnchor),
            gums.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gums.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gums.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
