//
//  DraftsViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 05/12/22.
//

import UIKit

class DraftsViewController: UIViewController {
    
    weak var managerDelegate: ManagerDelegate?
        
    init(managerDelegate: ManagerDelegate) {
        self.managerDelegate = managerDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var samplePill: DraftPill = {
        let pill = DraftPill()
        pill.pillLabel.text = "Back to Sample"
        pill.translatesAutoresizingMaskIntoConstraints = false

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pillFunc))
        pill.isUserInteractionEnabled = true
        pill.addGestureRecognizer(tapGesture)

        return pill
    }()
    
    @objc func pillFunc() {
        self.managerDelegate?.scrollToTop()
    }
    
    private lazy var gumPacks: PacksTexture = {
        let image = PacksTexture(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
    }

}

extension DraftsViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupHierarchy() {
        view.addSubview(gumPacks)
        view.addSubview(samplePill)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gumPacks.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gumPacks.centerYAnchor.constraint(equalTo: view.topAnchor),
            gumPacks.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.6),
            gumPacks.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.width * 1)),
            
            samplePill.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            samplePill.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            samplePill.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
