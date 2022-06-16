//
//  HomeViewController.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 06/06/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            CellType.allCases.forEach {
                collectionView.register(UINib(nibName: $0.nibName, bundle: nil),
                                        forCellWithReuseIdentifier: $0.identifier)
            }
            let layout = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout) ?? UICollectionViewFlowLayout()
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    private let viewModel = HomeViewModel(loader: RemoteTopStoriesLoader())
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        viewModel.delegate = self
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        viewModel.loadStories()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.itemAt(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellType.identifier, for: indexPath)
        if let cell = cell as? CellProtocol {
            cell.configure(with: cellViewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getArticleDetail(at: indexPath)
        ArticleCoordinator(viewController: self).presentViewController(with: article)
    }
    
}

extension HomeViewController: HomePageProtocol {
    func didReceiveData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onLoadingData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}
