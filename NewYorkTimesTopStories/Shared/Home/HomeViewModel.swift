//
//  HomeViewModel.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 07/06/2022.
//

import Foundation

protocol HomePageProtocol: AnyObject {
    func onLoadingData()
    func didReceiveData()
}

class HomeViewModel {
    private var cells: [CellViewModelProtocol] = [EmptyCellViewModel(informationMessage: "")]
    private var articles: [Article] = []
    weak var delegate: HomePageProtocol?
    let loader: TopStoriesLoader
    init(loader: TopStoriesLoader) {
        self.loader = loader
        loadStories()
    }
    
    var cellCount: Int {
        return cells.count
    }
    
    func itemAt(indexPath: IndexPath) -> CellViewModelProtocol {
        return cells[indexPath.row]
    }
    
    func loadStories() {
        loader.getTopStories(completion: { response in
            switch response {
            case .success(let response):
                let cellViewModels = response.articles.map {
                    TopStoryCellViewModel(imageURL: $0.multimedia?.first?.url,
                                          title: $0.title,
                                          author: $0.author)
                }
                self.cells = cellViewModels
                self.articles = response.articles
                self.delegate?.didReceiveData()
            case .failure(let failure):
                self.cells = [EmptyCellViewModel(informationMessage: failure.localizedDescription)]
                self.delegate?.didReceiveData()
            }
        })
    }
    
    func getArticleDetail(at indexPath: IndexPath) -> ArticleDetail {
        let article = self.articles[indexPath.row]
        return ArticleDetail(title: article.title,
                             description: article.description,
                             imageUrl: article.multimedia?.first?.url,
                             author: article.author,
                             publishDate: article.publishingDate,
                             url: article.url)
    }
}
