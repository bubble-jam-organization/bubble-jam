//
//  UploadDraftButtonView.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 14/02/23.
//

import UIKit

class UploadButton: UIView {

    private lazy var uploadIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "square.and.arrow.up.fill"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .gray
        return icon
    }()
    
    private lazy var uploadLabel: UILabel = {
       let label = UILabel()
        label.text = NSLocalizedString("upload draft", comment: "upload jam")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .title1, weight: .bold)
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

extension UploadButton: ViewCoding {
    func setupView() {}

    func setupHierarchy() {
        self.addSubview(uploadIcon)
        self.addSubview(uploadLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            uploadIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            uploadIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            uploadLabel.topAnchor.constraint(equalTo: uploadIcon.bottomAnchor, constant: 10),
            uploadLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            uploadLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
}
