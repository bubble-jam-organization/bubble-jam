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
    
    private lazy var samplerFrame: UIView = {
       
        let circle = UIView(frame: .zero)
        circle.backgroundColor = .clear
        circle.layer.cornerRadius = sizeOfFrame! / 2
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        return circle
        
    }()
    
    private lazy var samplerTexture: SampleTexture = {
        
        let texture = SampleTexture(frame: .zero, sizeOfCircle: 300)
        texture.translatesAutoresizingMaskIntoConstraints = false
        texture.layer.cornerRadius = sizeOfFrame! / 2
        texture.contentMode = .scaleAspectFit
        texture.clipsToBounds = true
        
        return texture
        
    }()
    
    init(frame: CGRect, sizeOfFrame: CGFloat) {
        super.init(frame: .zero)
        self.sizeOfFrame = sizeOfFrame
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SamplePlayerFrame: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(samplerFrame)
        samplerFrame.addSubview(samplerTexture)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            samplerFrame.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            samplerFrame.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            samplerFrame.widthAnchor.constraint(equalToConstant: sizeOfFrame!),
            samplerFrame.heightAnchor.constraint(equalToConstant: sizeOfFrame!),
            
            samplerTexture.centerXAnchor.constraint(equalTo: samplerFrame.centerXAnchor),
            samplerTexture.centerYAnchor.constraint(equalTo: samplerFrame.centerYAnchor),
            samplerTexture.widthAnchor.constraint(equalToConstant: sizeOfFrame!),
            samplerTexture.heightAnchor.constraint(equalToConstant: sizeOfFrame!)
        ])
    }
    
}
