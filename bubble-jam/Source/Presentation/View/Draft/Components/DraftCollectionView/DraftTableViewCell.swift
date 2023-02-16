//
//  DraftCollectionViewCell.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 16/02/23.
//

import UIKit

class DraftTableViewCell: UITableViewCell {
    static let cellID = "DraftCellID"
    
    var draft: DraftViewModel? {
        didSet {
            draftTitle.text = draft?.audioName
            draftDuration.text = draft?.audioDuration
        }
    }
    
    var buttonState: Bool = false {
        didSet {
            if !buttonState {
                playStateButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            } else {
                playStateButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            }

        }
    }
    
    private lazy var draftImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "guitars"))
        image.tintColor = .black
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var draftTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.preferredMaxLayoutWidth = 36
        label.font = UIFont.preferredFont(for: .body, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private var draftDuration: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .caption1, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playStateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func pressed() {
        buttonState.toggle()
    }
    
    private var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = UIStackView.spacingUseSystem
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 18, bottom: 5, right: 12)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = UIStackView.spacingUseSystem
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 5)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension DraftTableViewCell: ViewCoding {
    func setupView() {
        self.backgroundColor = .white
    }
    
    func setupHierarchy() {
        self.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(draftImage)
        horizontalStack.addArrangedSubview(draftTitle)
        verticalStack.addArrangedSubview(draftDuration)
        verticalStack.addArrangedSubview(playStateButton)
        horizontalStack.addArrangedSubview(verticalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
