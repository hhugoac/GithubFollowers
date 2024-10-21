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
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
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
                    return
                }
                self.updateData(on: self.followers)
                    print(String(describing: followers))
                case .failure(let errorMessage):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: itemIdentifier)
            return cell
        })
    }
        
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowersViewController: UICollectionViewDelegate {
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
