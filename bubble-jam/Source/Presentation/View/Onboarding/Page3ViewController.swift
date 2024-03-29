//
//  Page3ViewController.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 11/12/22.
//

import UIKit

class Page3ViewController: UIViewController {
    private lazy var tutorialImage: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "DownloadButton")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var tutorialTitle: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.text = NSLocalizedString("Downloading a Sample", comment: "Downloading a Sample")
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
        label.textContainer.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.attributedText = attributedText(
            withString: NSLocalizedString("page3tutorial", comment: "page 3 tutorial text"),
            boldString: [NSLocalizedString("download the sample", comment: "bold1"),
                         NSLocalizedString("tap on the ”Download Sample”", comment: "bold2"),
                         NSLocalizedString("Good luck!", comment: "bold3")],
            font: UIFont.preferredFont(for: .body, weight: .regular))
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.isEditable = false
        return label
    }()
    
    private lazy var goToMainScreenButton: PillButtonComponent = {
        let button = PillButtonComponent(frame: .zero)
        button.pillLabel.text = NSLocalizedString("Start Now!", comment: "Start Now!")
        button.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToMainScreen))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.accessibilityLabel = NSLocalizedString("Start Now!", comment: "Start Now!")
        button.isAccessibilityElement = true
        return button
    }()
    
    @objc func goToMainScreen() {
        print("a")
        navigationController?.show(ManagerViewController(), sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        print(goToMainScreenButton.frame)
    }
    
}
extension Page3ViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8862745098, blue: 0.9529411765, alpha: 1)
    }
    
    func setupHierarchy() {
        view.addSubview(tutorialImage)
        view.addSubview(tutorialTitle)
        view.addSubview(tutorialText)
        view.addSubview(goToMainScreenButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tutorialImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tutorialImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialImage.widthAnchor.constraint(equalToConstant: 240),
            tutorialImage.heightAnchor.constraint(equalToConstant: 140),
            tutorialTitle.topAnchor.constraint(equalTo: tutorialImage.bottomAnchor, constant: 10),
            tutorialTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12),
            tutorialTitle.heightAnchor.constraint(equalToConstant: 75),
            tutorialText.topAnchor.constraint(equalTo: tutorialTitle.bottomAnchor, constant: 10),
            tutorialText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            tutorialText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialText.heightAnchor.constraint(equalToConstant: 150),
            goToMainScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.height * 0.14)),
            goToMainScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToMainScreenButton.heightAnchor.constraint(equalToConstant: ((goToMainScreenButton.radius ?? 20) * 3))

        ])
    }
}
