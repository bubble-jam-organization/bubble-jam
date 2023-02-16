//
//  DraftsViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 05/12/22.
//

import UIKit

class DraftsViewController: UIViewController {
    
    weak var managerDelegate: ManagerDelegate?
    
    var dataSource = [DraftViewModel]()
        
    init(managerDelegate: ManagerDelegate) {
        self.managerDelegate = managerDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Jams"
        label.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        label.textColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var draftsCollection: DraftTableView = {
        let collection = DraftTableView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var gumPacks: PacksTexture = {
        let image = PacksTexture(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var micButton: MicButton = {
        let button = MicButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension DraftsViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .clear
        draftsCollection.dataSource = self
        draftsCollection.delegate = self
        dataSource = DraftViewModel.mock
        draftsCollection.estimatedRowHeight = 86
    }
    
    func setupHierarchy() {
        view.addSubview(gumPacks)
        view.addSubview(draftsCollection)
        view.addSubview(micButton)
        view.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gumPacks.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gumPacks.centerYAnchor.constraint(equalTo: view.topAnchor),
            gumPacks.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.6),
            gumPacks.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.width * 1)),
            
            titleLabel.topAnchor.constraint(equalTo: gumPacks.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            draftsCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            draftsCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            draftsCollection.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            draftsCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            micButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            micButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            micButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            micButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 180)
        ])
    }
    
}

extension DraftsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DraftTableViewCell.cellID,
            for: indexPath
        ) as? DraftTableViewCell else {
            return UITableViewCell()
        }
        cell.draft = dataSource[indexPath.row]
        return cell
    }
}
