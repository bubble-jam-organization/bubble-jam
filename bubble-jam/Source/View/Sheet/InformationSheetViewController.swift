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
    
    private lazy var downloadBox: DownloadButton = {
        let box = DownloadButton(frame: .zero)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
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
        view.addSubview(downloadBox)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            challengeBanner.topAnchor.constraint(equalTo: view.topAnchor),
            challengeBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            challengeBanner.widthAnchor.constraint(equalTo: view.widthAnchor),
            challengeBanner.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.width * 0.5625)),
            
//            downloadBox.topAnchor.constraint(equalTo: sampleFrame.bottomAnchor),
            downloadBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            downloadBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            downloadBox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
        ])
    }
     
}
