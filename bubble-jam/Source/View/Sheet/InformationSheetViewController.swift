//
//  SheetViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 30/11/22.
//

import UIKit

class InformationSheetViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
        
        let background = Background(frame: .zero)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
        
    }()
    
    private lazy var challengeBanner: UIImageView = {
        
        let banner = ChallengeBanner(frame: .zero)
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.layer.cornerRadius = 50
        return banner
        
    }()
    
    private lazy var testLabel: UILabel = {
        
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this label is cented to x and anchored to bottom. i am now extrapolating the size limit of this"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension InformationSheetViewController: ViewCoding {
    func setupView() {
        
    }
    
    func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(challengeBanner)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            challengeBanner.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            challengeBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            challengeBanner.widthAnchor.constraint(equalTo: view.widthAnchor),
            challengeBanner.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.width * 0.5625)
)
        ])
    }
     
}
