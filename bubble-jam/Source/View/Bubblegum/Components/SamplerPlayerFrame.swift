//
//  SamplePlayerFrame.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/11/22.
//

import UIKit

class SamplePlayerFrame: UIView {
    
    // TODO: Adicionar drop shadow ao frame.

    var sizeOfFrame: CGFloat?
    
    private lazy var samplerTexture: UIImageView = {
        
        let texture = UIImageView(frame: .zero)
        texture.image = UIImage(named: "Bubblegum")
        texture.translatesAutoresizingMaskIntoConstraints = false
        texture.contentMode = .scaleAspectFit
        texture.layer.cornerRadius = sizeOfFrame! / 2
        texture.clipsToBounds = true
        
        return texture
        
    }()

//    private lazy var samplerTexture: SampleTexture = {
//
//        let texture = SampleTexture(frame: .zero, sizeOfCircle: 300)
//        texture.translatesAutoresizingMaskIntoConstraints = false
//        texture.layer.cornerRadius = sizeOfFrame! / 2
//        texture.contentMode = .scaleAspectFit
//        texture.clipsToBounds = true
//
//        return texture
//
//    }()
//
    init(frame: CGRect, sizeOfFrame: CGFloat) {
        super.init(frame: .zero)
        self.sizeOfFrame = sizeOfFrame
        self.layer.cornerRadius = sizeOfFrame/2
//        self.layer.backgroundColor = UIColor.red.cgColor
//        self.layer.borderColor = UIColor.systemRed.cgColor
//        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let center = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        return pow(center.x-point.x, 2) + pow(center.y - point.y, 2) <= pow(bounds.size.width/2, 2)
    }
    
    
}

extension SamplePlayerFrame: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
//        self.addSubview(samplerFrame)
        addSubview(samplerTexture)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            samplerFrame.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            samplerFrame.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            samplerFrame.widthAnchor.constraint(equalToConstant: sizeOfFrame!),
//            samplerFrame.heightAnchor.constraint(equalToConstant: sizeOfFrame!),
            
            samplerTexture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            samplerTexture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            samplerTexture.widthAnchor.constraint(equalToConstant: sizeOfFrame!),
            samplerTexture.heightAnchor.constraint(equalToConstant: sizeOfFrame!)
        ])
    }
    
}
