//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 14/10/24.
//

import UIKit

class FavoritesListViewController: UIViewController {

    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
