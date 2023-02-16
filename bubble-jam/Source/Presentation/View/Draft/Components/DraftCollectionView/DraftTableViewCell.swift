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
        image.frame = .zero
        return image
    }()
    
    private var draftTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.font = UIFont.preferredFont(for: .body, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = .zero
        return label
    }()
    
    private var titleStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = UIStackView.spacingUseSystem
        stack.frame = .zero
        return stack
    }()
    
    private var draftDuration: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .callout, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = .zero
        return label
    }()
    
    private lazy var playStateButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24.0)
        let image = UIImage(systemName: "play.circle", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func pressed() {
        buttonState.toggle()
    }
    
    private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 5)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.frame = .zero
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(x: 0.0, y: 0.0, width: 200, height: 90)
    }
}

extension DraftTableViewCell: ViewCoding {
    func setupView() {
        self.backgroundColor = .white
    }
    
    func setupHierarchy() {
        self.addSubview(draftImage)
        self.addSubview(draftTitle)
        verticalStack.addArrangedSubview(draftDuration)
        verticalStack.addArrangedSubview(playStateButton)
        self.addSubview(verticalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            verticalStack.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            draftImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            draftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            draftImage.widthAnchor.constraint(equalToConstant: 56),
            draftImage.heightAnchor.constraint(equalToConstant: 56),
            
            draftTitle.leadingAnchor.constraint(equalTo: draftImage.trailingAnchor, constant: 32),
            draftTitle.topAnchor.constraint(equalTo: draftImage.topAnchor),
            draftTitle.trailingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: -16),
            draftTitle.widthAnchor.constraint(equalToConstant: 100)

        ])
    }
}
