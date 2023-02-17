//
//  PillButtonComponent.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 15/02/23.
//

import UIKit

class PillButtonComponent: UIButton {
    var leftSideSymbol: UIImage? {
        didSet {
            pillSymbol.image = leftSideSymbol?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 32))
        }
    }
    
    var radius: CGFloat? {
        didSet {
            horizontalStack.layer.cornerRadius = radius!
        }
    }
    
    private var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        stackView.layer.cornerRadius = 20
        return stackView
    }()
    
    private var pillSymbol: UIImageView = {
        let mic = UIImageView(image: nil)
        mic.translatesAutoresizingMaskIntoConstraints = false
        mic.tintColor = .white
        mic.contentMode = .scaleAspectFill
        return mic
    }()
    
    var pillLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.contentMode = .center
        label.font = UIFont.preferredFont(for: .body, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension PillButtonComponent: ViewCoding {
    func setupHierarchy() {
        self.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(pillSymbol)
        horizontalStack.addArrangedSubview(pillLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            horizontalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            horizontalStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
