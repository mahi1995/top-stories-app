//
//  ArticleViewModel.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import Foundation

class ArticleViewModel {
    private let article: ArticleDetail
    
    init(article: ArticleDetail) {
        self.article = article
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
    
    
}
