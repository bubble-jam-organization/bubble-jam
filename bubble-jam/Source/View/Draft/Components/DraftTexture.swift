//
//  DraftTexture.swift
//  bubble-jam
//
//  Created by Caio Soares on 06/12/22.
//

import UIKit

class DraftTexture: UIView {

    private lazy var draftBackground: UIImageView = {
        let texture = UIImageView(frame: .zero)
        texture.image = UIImage(named: "gum6")
        texture.translatesAutoresizingMaskIntoConstraints = false
        texture.contentMode = .scaleAspectFit
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

extension DraftTexture: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(draftBackground)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            draftBackground.topAnchor.constraint(equalTo: self.topAnchor),
            draftBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            draftBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            draftBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
