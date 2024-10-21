//
//  Extensions.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 21/10/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
