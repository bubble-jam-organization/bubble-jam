//
//  DraftEmptyStateViewCell.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 16/02/23.
//

import UIKit

class DraftEmptyStateViewCell: UITableViewCell {
    private var label: UILabel = {
        let label = UILabel()
        label.text = "i'ts so empty arround here..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension DraftEmptyStateViewCell: ViewCoding {
    func setupHierarchy() {
        addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
