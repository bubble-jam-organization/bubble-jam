//
//  DraftsViewController.swift
//  bubble-jam
//
//  Created by Caio Soares on 05/12/22.
//

import UIKit
import UniformTypeIdentifiers

protocol DraftViewDelegate: AnyObject {
    func startLoading()
    func hideLoading()
    func succesfullyUploadDraft(_ jam: Draft)
    func failWhileUploadingDraft(_ error: Error)
}

class DraftsViewController: UIViewController, AlertPresentable {
    weak var managerDelegate: ManagerDelegate?
    private let presenter: DraftsPresenting
    
    var dataSource = [DraftViewModel]()
    
    init(managerDelegate: ManagerDelegate, presenter: DraftsPresenting) {
        self.managerDelegate = managerDelegate
        self.presenter = presenter
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
    
    private var draftsTableView: DraftTableView = {
        let tableView = DraftTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.borderColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.5960784314, alpha: 0.5)
        tableView.layer.borderWidth = 10
        return tableView
    }()
    
    private var tableViewHeader: UIView = {
        let headerView =  UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
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
    
   @objc func onSwipeDown() { managerDelegate?.scrollToTop() }
}

extension DraftsViewController: UIDocumentPickerDelegate {
    func loadUserAudios() {
        weak var weakSelf = self
        let document = UIDocumentPickerViewController(forOpeningContentTypes: [.audio])
        document.allowsMultipleSelection = false
        weakSelf?.present(document, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        let draftJam = Draft(audio: url)
        Task { await presenter.uploadJam(draft: draftJam) }
    }
}

extension DraftsViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = .clear
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeDown))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        draftsTableView.dataSource = self
        draftsTableView.delegate = self
        dataSource = DraftViewModel.mock
        micButton.addJamButtonTap = loadUserAudios
    }
    
    func setupHierarchy() {
        view.addSubview(gumPacks)
        view.addSubview(draftsTableView)
        view.addSubview(micButton)
        view.addSubview(tableViewHeader)
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
            
            draftsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            draftsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            draftsTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            draftsTableView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.35),
            
            micButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            micButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            micButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            micButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 160),
            
            tableViewHeader.bottomAnchor.constraint(equalTo: draftsTableView.topAnchor),
            tableViewHeader.leadingAnchor.constraint(equalTo: draftsTableView.leadingAnchor),
            tableViewHeader.trailingAnchor.constraint(equalTo: draftsTableView.trailingAnchor),
            tableViewHeader.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}

extension DraftsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty { return 1 }
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource.isEmpty { return DraftEmptyStateViewCell() }
        
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

extension DraftsViewController: DraftViewDelegate {
    func startLoading() {
        print("Presenter says: \(#function)")
        
        /*
         
         let loadingView = UIView(frame: UIScreen.main.bounds)
         loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
         let spinner = UIActivityIndicatorView(style: .gray)
         spinner.center = loadingView.center
         spinner.startAnimating()
         loadingView.addSubview(spinner)
         view.addSubview(loadingView)
         view.isUserInteractionEnabled = false
         
         Encontrei uma explicação de como fazer uma loadingView e foi isso que encontrei.
         Testar quando conseguir compilar no telefone.
         
         */
    }
    
    func hideLoading() {
        print("Presenter says: \(#function)")
        
        /*
         
         for subview in view.subviews {
                 if subview is UIActivityIndicatorView {
                     subview.removeFromSuperview()
                 }
             }
             view.isUserInteractionEnabled = true
         
         Idem do bloco acima.
         
         */
    }
    
    func succesfullyUploadDraft(_ jam: Draft) {
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.removeAll()
            self?.dataSource.append(
                DraftViewModel(audioPath: jam.audio, audioName: "My new jam!", audioDuration: "1:00")
            )
            self?.draftsTableView.reloadData()
        }
    }
    
    func failWhileUploadingDraft(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: "Presenter says error", message: error.localizedDescription)
        }
    }
}
