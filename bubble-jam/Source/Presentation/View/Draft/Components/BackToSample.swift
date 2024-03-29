//
//  BackToSample.swift
//  bubble-jam
//
//  Created by Caio Soares on 07/12/22.
//

import UIKit

class BackToSample: UIView {

    private lazy var pillBox: UIView = {
        let pill = UIView(frame: CGRect(x: 0, y: 0, width: 230, height: 120))
        pill.translatesAutoresizingMaskIntoConstraints = false
        pill.layer.cornerRadius = 20
        pill.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
         
        return pill
    }()
    
    private lazy var pillSymbol: UIImageView = {
        let mic = UIImageView(image: UIImage(systemName: "music.mic.circle.fill"))
        mic.translatesAutoresizingMaskIntoConstraints = false
        mic.tintColor = .white
        return mic
    }()
    
    private lazy var pillLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Back to sample", comment: "Back to Sample button label")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.font = UIFont.preferredFont(for: .title1, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BackToSample: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(pillBox)
        pillBox.addSubview(pillSymbol)
        pillBox.addSubview(pillLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pillBox.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pillBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pillBox.widthAnchor.constraint(equalToConstant: 230),
            pillBox.heightAnchor.constraint(equalToConstant: 120),
            
            pillSymbol.leadingAnchor.constraint(equalTo: pillBox.leadingAnchor, constant: 5),
            pillSymbol.centerYAnchor.constraint(equalTo: pillBox.centerYAnchor),
            pillSymbol.widthAnchor.constraint(equalToConstant: 45),
            pillSymbol.heightAnchor.constraint(equalToConstant: 45),

            pillLabel.topAnchor.constraint(equalTo: pillSymbol.topAnchor),
            pillLabel.leadingAnchor.constraint(equalTo: pillSymbol.trailingAnchor, constant: 15),
            pillLabel.trailingAnchor.constraint(equalTo: pillBox.trailingAnchor, constant: 5),
            pillLabel.bottomAnchor.constraint(equalTo: pillSymbol.bottomAnchor)
        ])
    }
}
