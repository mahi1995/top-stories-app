//
//  HomeViewModel.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 07/06/2022.
//

import Foundation
import UIKit

protocol HomePageDelegate: AnyObject {
    func onLoadingData()
    func didReceiveData()
}

class HomeViewModel {
    private var cells: [CellViewModelProtocol] = []
    private var articles: [Article] = []
    weak var delegate: HomePageDelegate?
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
        cells.append(LoadingIndicatorCellViewModel())
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
                self.cells = [EmptyCellViewModel(informationMessage: failure.errorDescription ?? Error.genericErrorDescription)]
                self.delegate?.didReceiveData()
            }
        })
    }
    
    func getArticleDetail(at indexPath: IndexPath) -> ArticleDetail {
        let article = self.articles[indexPath.row]
        let image = (self.cells[indexPath.row] as? TopStoryCellViewModel)?.image
        return ArticleDetail(title: article.title,
                             description: article.description,
                             imageUrl: article.multimedia?.first?.url,
                             image: image,
                             author: article.author,
                             publishDate: article.publishingDate,
                             url: article.url)
    }
    
    func updateCells(with image: UIImage, url: URL) {
        let urlString = url.absoluteString
        guard let cellViewModels = cells as? [TopStoryCellViewModel] else { return }
        var updatedCellViewModels: [TopStoryCellViewModel] = []
        for cell in cellViewModels {
            if cell.imageURL == urlString {
                let topStoryCellViewModel = TopStoryCellViewModel(imageURL: cell.imageURL,
                                                                  title: cell.title,
                                                                  author: cell.author,
                                                                  image: image)
                updatedCellViewModels.append(topStoryCellViewModel)
            } else {
                updatedCellViewModels.append(cell)
            }
        }
        self.cells = updatedCellViewModels
    }
}
