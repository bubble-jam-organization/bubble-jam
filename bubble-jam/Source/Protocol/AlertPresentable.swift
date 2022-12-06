//
//  AlertPresentable.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
import UIKit

protocol AlertPresentable { }

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
