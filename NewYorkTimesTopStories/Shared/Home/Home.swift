//
//  Home.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

protocol CellViewModelProtocol {
    var cellType: CellType { get }
}

enum CellType: String, CaseIterable {
    case story = "storyCell"
    case empty = "emptyCell"
    case loading = "loadingCell"
    
    var nibName: String {
        switch self {
        case .story:
            return "TopStoryCell"
        case .empty:
            return "EmptyViewCell"
        case .loading:
            return "LoadingIndicatorCell"
        }
    }
    
    var identifier: String {
        return self.rawValue
    }
}
