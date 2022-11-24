//
//  SamplerPlayButton.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

class SamplerPlayButton: UIView {
    
    var sizeOfButton: CGFloat?

    private lazy var playButton: UIView = {
        
        let button = UIView(frame: CGRectMake(0, 0, sizeOfButton!, sizeOfButton!))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = sizeOfButton! / 2
        button.backgroundColor = .white
        return button
        
    }()
    
    private lazy var playSymbol: UIImageView = {
        
        let symbol = UIImageView(image: UIImage(systemName: "play.fill"))
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.tintColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        return symbol
        
    }()
    
    init(frame: CGRect, sizeOfButton: CGFloat) {
        super.init(frame: .zero)
        self.sizeOfButton = sizeOfButton
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SamplerPlayButton: ViewCoding {
    func setupView() {
        //
    }
    
    func setupHierarchy() {
        self.addSubview(playButton)
        playButton.addSubview(playSymbol)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: sizeOfButton!),
            playButton.heightAnchor.constraint(equalToConstant: sizeOfButton!),
        
            playSymbol.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playSymbol.widthAnchor.constraint(equalToConstant: sizeOfButton! * 0.5),
            playSymbol.heightAnchor.constraint(equalToConstant: sizeOfButton! * 0.6),
        ])
    }
}
