//
//  DownloadButton.swift
//  bubble-jam
//
//  Created by Caio Soares on 30/11/22.
//

import UIKit

class DownloadButton: UIView {

    private lazy var downloadButton: UIView = {
        let box = UIView(frame: CGRect(x: 0, y: 0, width: 185, height: 90))
        box.translatesAutoresizingMaskIntoConstraints = false
        box.layer.cornerRadius = 10
        box.backgroundColor = #colorLiteral(red: 0.368627451, green: 0, blue: 0.5960784314, alpha: 0.5)
        box.layer.opacity = 0.50
        
        return box
    }()
    
    private lazy var boxSymbol: UIImageView = {
        let export = UIImageView(image: UIImage(systemName: "square.and.arrow.up.fill"))
        export.translatesAutoresizingMaskIntoConstraints = false
        export.tintColor = .white
        return export
    }()
    
    private lazy var exportLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Export Audio"
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

extension DownloadButton: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.addSubview(downloadButton)
        self.addSubview(boxSymbol)
        self.addSubview(exportLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            downloadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            downloadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 185),
            downloadButton.heightAnchor.constraint(equalToConstant: 90),
            
            boxSymbol.centerXAnchor.constraint(equalTo: downloadButton.centerXAnchor),
            boxSymbol.topAnchor.constraint(equalTo: downloadButton.topAnchor, constant: 18),
            boxSymbol.bottomAnchor.constraint(equalTo: exportLabel.topAnchor, constant: 18),
            boxSymbol.widthAnchor.constraint(equalToConstant: 24),
            boxSymbol.heightAnchor.constraint(equalToConstant: 28),
            
            exportLabel.bottomAnchor.constraint(equalTo: downloadButton.bottomAnchor),
            exportLabel.centerXAnchor.constraint(equalTo: downloadButton.centerXAnchor),
        ])
    }
    
}
