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
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.itemAt(indexPath: indexPath)
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellType.identifier, for: indexPath)
    }
    
}

extension HomeViewController: HomePageProtocol {
    func didReceiveData() {
        collectionView.reloadData()
    }
    
}
