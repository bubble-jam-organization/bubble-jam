//
//  ScrollViewExtensions.swift
//  bubble-jam
//
//  Created by Caio Soares on 07/12/22.
//

import UIKit

extension UIScrollView {
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: true)
    }

    func scrollToTop() {
        let bottomOffset = CGPoint(x: 0, y: 0)
        setContentOffset(bottomOffset, animated: true)
    }
}
