//
//  ArticleCoordinator.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import UIKit

class ArticleCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func pushViewController(with article: ArticleDetail) {
        let viewModel = ArticleViewModel(article: article, loader: RemoteArticleLoader())
        let viewController = ArticleViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
