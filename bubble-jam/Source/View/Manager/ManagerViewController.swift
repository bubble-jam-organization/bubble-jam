//
//  ManagerViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 07/12/22.
//

import UIKit

protocol ManagerDelegate: AnyObject {
    func scrollToTop()
    func scrollToBottom()
}

class ManagerViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bubblegumView: BubblegumViewController = {
        let audioService = AudioService()
        let downloadService = DownloadService()
        let datetimeService = DatetimeService()
        let presenter = BubblegumPresenter(audioService: audioService, downloadService: downloadService, datetimeService: datetimeService)
        let delegate = self
        let viewController = BubblegumViewController(presenter: presenter, managerDelegate: delegate)
        presenter.viewDelegate = viewController
        
        return viewController
    }()
    
    private lazy var draftView = DraftsViewController(managerDelegate: self)
    
    private lazy var managerScrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension ManagerViewController: ManagerDelegate {
    
    func scrollToTop() {
        managerScrollView.scrollToTop()
    }
    
    func scrollToBottom() {
        managerScrollView.scrollToBottom()
    }
    
}

extension ManagerViewController: ViewCoding {
   
    func setupView() {
        managerScrollView.contentInsetAdjustmentBehavior = .never
        self.managerScrollView.contentSize = CGSize(
            width: view.frame.width,
            height: 2 * view.frame.height
        )
    }
    
    func setupHierarchy() {
        view.addSubview(managerScrollView)
        
        addChild(draftView)
        draftView.willMove(toParent: self)
        managerScrollView.addSubview(draftView.view)
        draftView.didMove(toParent: self)
        
        addChild(bubblegumView)
        bubblegumView.willMove(toParent: self)
        managerScrollView.addSubview(bubblegumView.view)
        bubblegumView.didMove(toParent: self)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            managerScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            managerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            managerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            managerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bubblegumView.view.widthAnchor.constraint(equalToConstant: view.frame.width),
            bubblegumView.view.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            draftView.view.topAnchor.constraint(equalTo: bubblegumView.view.bottomAnchor),
            draftView.view.widthAnchor.constraint(equalToConstant: view.frame.width),
            draftView.view.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
    
}
