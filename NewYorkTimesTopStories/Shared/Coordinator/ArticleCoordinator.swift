//
//  ArticleCoordinator.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import UIKit

class ArticleCoordinator {
    let parentViewController: UIViewController
    
    init(viewController: UIViewController){
        parentViewController = viewController
    }
    
    func presentViewController(with article: ArticleDetail) {
        let viewModel = ArticleViewModel(article: article)
        let viewController = ArticleViewController(viewModel: viewModel)
        parentViewController.present(viewController, animated: true)
    }
}
