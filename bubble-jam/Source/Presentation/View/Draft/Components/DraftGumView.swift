//
//  UploadDraftButton.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 14/02/23.
//

import UIKit

class DraftGum: UIView {
    
    
    private lazy var gumImage: UIImageView = {
        let gum = UIImageView(image: UIImage(named: "gum7"))
        gum.translatesAutoresizingMaskIntoConstraints = false
        return gum
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DraftGum: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(gumImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gumImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gumImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
    
    
}

