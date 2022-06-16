//
//  TopStoryCellViewModel.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

struct TopStoryCellViewModel: CellViewModelProtocol {
    var cellType: CellType = .story
    let imageURL: String?
    let title: String
    let author: String
    var image: UIImage?
}
