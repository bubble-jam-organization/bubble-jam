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
    
    private lazy var tutorialTitle: UILabel = {
        let label = UILabel()
        label.text = "Downloading a Sample"
        label.textColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tutorialText: UILabel = {
        
       let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedText(
            withString: "To download the sample of a jam, simply tap on the ”Download Sample” button that appears at the bottom of the screen after you listen to it. Good luck!",
            boldString: ["download the sample", "tap on the ”Download Sample”", "Good luck!"],
            font: UIFont.systemFont(ofSize: 18, weight: .regular))
        label.textColor = .gray

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var goToMainScreenButton: DraftPill = {
        let button = DraftPill(frame: .zero)
        button.pillLabel.text = "Start Now!"
        button.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToMainScreen))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tap)
        button.backgroundColor = .yellow
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
            tutorialImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            tutorialImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialImage.widthAnchor.constraint(equalToConstant: 240),
            tutorialImage.heightAnchor.constraint(equalToConstant: 240),
            
            
            tutorialTitle.topAnchor.constraint(equalTo: tutorialImage.bottomAnchor,constant: 20),
            tutorialTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12),
            
            tutorialText.topAnchor.constraint(equalTo: tutorialTitle.bottomAnchor, constant: 40),
            tutorialText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            tutorialText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            goToMainScreenButton.topAnchor.constraint(equalTo: tutorialText.bottomAnchor, constant: 90),
            goToMainScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToMainScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])

    }
    
    
}

