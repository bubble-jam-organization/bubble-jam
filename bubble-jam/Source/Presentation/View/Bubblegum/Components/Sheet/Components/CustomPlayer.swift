//
//  CustomPlayer.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 02/03/23.
//

import UIKit

class CustomPlayer: UIView {
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "Play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder)  { nil }
}

extension CustomPlayer: ViewCoding {
    func setupHierarchy() {
        self.addSubview(playButton)
    }
    
    func setupConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 34),
            playButton.heightAnchor.constraint(equalToConstant: 34)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
    }
}
