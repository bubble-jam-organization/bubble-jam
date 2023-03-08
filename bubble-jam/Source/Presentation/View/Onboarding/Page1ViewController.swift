//
//  Page1ViewController.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 07/12/22.
//

import UIKit

class Page1ViewController: UIViewController {
    
    private lazy var tutorialImage: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "OnboardingJam")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var tutorialTitle: UILabel = {
        let label = UILabel()
        label.text = "Jams"
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.preferredFont(for: .title1, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var tutorialText: UITextView = {
        let label = UITextView()
        label.textContainer.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.attributedText = attributedText(
            withString: NSLocalizedString("page1tutorial", comment: "page 1 tutorial label"),
            boldString: [NSLocalizedString("Every week", comment: "Every week" ),
                         NSLocalizedString("short melody", comment: "short melody"),
                         NSLocalizedString("make the best song you can", comment: "make the best song you can")],
            font: UIFont.preferredFont(for: .body, weight: .regular))
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.isEditable = false
        label.backgroundColor = .clear
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Page1ViewController: ViewCoding {
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
            tutorialImage.widthAnchor.constraint(equalTo: tutorialImage.widthAnchor),
            tutorialImage.heightAnchor.constraint(equalTo: tutorialImage.heightAnchor),
            tutorialTitle.topAnchor.constraint(equalTo: tutorialImage.bottomAnchor, constant: 20),
            tutorialTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialText.topAnchor.constraint(equalTo: tutorialTitle.bottomAnchor, constant: 40),
            tutorialText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            tutorialText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialText.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension UIViewController {
    func attributedText(withString string: String, boldString: [String], font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            string: string,
            attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        for str in boldString {
            let range = (string as NSString).range(of: str)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }

        return attributedString
    }
}
