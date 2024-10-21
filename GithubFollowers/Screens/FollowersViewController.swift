//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 14/10/24.
//

import UIKit

class FollowersViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var user:String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page: Int = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(user: user, page: page)
        collectionView.dataSource = self
        collectionView.delegate = self
        //configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let width = view.frame.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 10)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier)
        
    }
    
    
    func getFollowers(user: String, page: Int) {
        NetworkManager.shared.getFollowers(for: user, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let followers):
                if (followers.count < 100) {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    // TODO: - Implements here the empty view
                    return
                }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                //self.updateData(on: self.followers)
                    print(String(describing: followers))
                case .failure(let errorMessage):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension FollowersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier, for: indexPath) as! FollowerCollectionViewCell
        let follower = self.followers[indexPath.row]
        cell.set(follower: follower)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - Implements here the navigationto the detail profile
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)  {
        let offset = scrollView.contentOffset.y
        let totalContentHecight = scrollView.contentSize.height
        let totalViewScrollViewHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHecight - totalViewScrollViewHeight ) {
            guard hasMoreFollowers else {return}
            page += 1
            self.getFollowers(user: user, page: page)
        }
        
    }
}
