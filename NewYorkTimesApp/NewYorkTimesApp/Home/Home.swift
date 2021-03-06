//
//  Home.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

protocol CellViewModelProtocol {
    var cellType: CellType { get }
}

protocol HomeCellDelegate: AnyObject {
    func onFinishImageDownload(image: UIImage, url: URL)
}

protocol CellProtocol {
    var delegate: HomeCellDelegate? { set get }
    func configure(with viewModel: CellViewModelProtocol)
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
