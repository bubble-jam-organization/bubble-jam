//
//  DraftsCollectionViewController.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 16/02/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class DraftTableView: UITableView {
    private let flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        return flow
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(DraftTableViewCell.self, forCellReuseIdentifier: DraftTableViewCell.cellID)
    }
    
    required init?(coder: NSCoder) { nil }
}
