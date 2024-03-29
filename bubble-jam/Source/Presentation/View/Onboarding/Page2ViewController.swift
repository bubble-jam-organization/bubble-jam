//
//  Page2ViewController.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 07/12/22.
//

import UIKit

class Page2ViewController: UIViewController {
    
    private lazy var tutorialImage: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "AppButton")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var tutorialTitle: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.text = NSLocalizedString("Listening to a Sample", comment: "Listening to a Sample")
        label.textColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.preferredFont(for: .title1, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        
        label.isEditable = false
        return label
    }()
    
    private lazy var tutorialText: UITextView = {
        
        let label = UITextView()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.attributedText = attributedText(
            withString: NSLocalizedString("page2tutorial", comment: "page 2 tutorial text"),
            boldString: [NSLocalizedString("Tap on the Bubble", comment: "Tap on the Bubble"), NSLocalizedString("play the sample", comment: "play the sample"), "open a screen",
                         NSLocalizedString("allows", comment: "allows"), NSLocalizedString("download it", comment: "download it")],
            font: UIFont.preferredFont(for: .body, weight: .regular))
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.isEditable = false
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
        
    }
    
}
extension Page2ViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8862745098, blue: 0.9529411765, alpha: 1)
    }
    
    func setupHierarchy() {
        view.addSubview(tutorialImage)
        view.addSubview(tutorialTitle)
        view.addSubview(tutorialText)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tutorialImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tutorialImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialImage.widthAnchor.constraint(equalToConstant: 240),
            tutorialImage.heightAnchor.constraint(equalToConstant: 200),
            tutorialTitle.topAnchor.constraint(equalTo: tutorialImage.bottomAnchor, constant: 20),
            tutorialTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialTitle.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tutorialTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 75),
            tutorialText.topAnchor.constraint(equalTo: tutorialTitle.bottomAnchor, constant: 10),
            tutorialText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            tutorialText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialText.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
}
