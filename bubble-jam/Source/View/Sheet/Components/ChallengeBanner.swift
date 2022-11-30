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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: self.topAnchor),
            banner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            banner.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
}
