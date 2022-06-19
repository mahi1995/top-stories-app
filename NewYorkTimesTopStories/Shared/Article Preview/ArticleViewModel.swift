//
//  ArticleViewModel.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import Foundation
import UIKit

protocol ArticleDelegate: AnyObject {
    func onReceivedData(with content: String)
    func onErrorReturned(_ errorMessage: String)
}

class ArticleViewModel {
    private let article: ArticleDetail
    private let loader: ArticleLoader
    weak var delegate: ArticleDelegate?
    
    init(article: ArticleDetail, loader: ArticleLoader) {
        self.article = article
        self.loader = loader
    }
    
    var title: String {
        return article.title
    }
    
    var description: String {
        return article.description
    }
    
    var author: String {
        return article.author
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: article.publishDate)!
        let calendar = Calendar.current
        let monthInt = Calendar.current.component(.month, from: date)
        let month = calendar.monthSymbols[monthInt - 1]
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "Published on \(month) \(components.day!), \(components.year!)"
    }
    
    var image: UIImage? {
        return article.image
    }
    
    var imageURL: String? {
        return article.imageUrl
    }
    
    var seeMoreAttributedString: NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
                                  NSAttributedString.Key.foregroundColor: UIColor.blue] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: "See More", attributes: underlineAttribute)
        return underlineAttributedString
    }
    
    var url: String {
        return article.url
    }
    
    func fetchPreview(completion: @escaping ((String) -> Void) = { _ in }) {
        loader.getArticle(with: url) { [weak self] result in
            switch result {
            case .success(let response):
                guard let content = response.documents.first?.leadParagraph else {
                    let errorMessage = "Oops! There is no preview for this article."
                    self?.delegate?.onErrorReturned(errorMessage)
                    completion(errorMessage)
                    return
                }
                self?.delegate?.onReceivedData(with: content)
                completion(content)
            case .failure(let error):
                let errorMessage = error.errorDescription ?? Error.genericErrorDescription
                self?.delegate?.onErrorReturned(errorMessage)
                completion(errorMessage)
            }
        }
    }
    
}
