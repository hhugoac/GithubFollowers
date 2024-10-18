//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 14/10/24.
//

import UIKit

class FollowersViewController: UIViewController {
    
    var user:String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor  = .systemRed
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier)
        
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: user, page: 1) { result in
            switch result {
                case .success(let followers):
                    print("Followers: \(followers.count)")
                    print(String(describing: followers))
                case .failure(let errorMessage):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage.rawValue, buttonTitle: "OK")
            }
        }
    }
}
