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
        if UIAccessibility.isReduceMotionEnabled {
            setContentOffset(bottomOffset, animated: false)
        } else {
            setContentOffset(bottomOffset, animated: true)
        }

    }

    func scrollToTop() {
        let bottomOffset = CGPoint(x: 0, y: 0)
        if UIAccessibility.isReduceMotionEnabled {
            setContentOffset(bottomOffset, animated: false)
        } else {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
