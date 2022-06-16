//
//  TopStoryCellViewModel.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

struct TopStoryCellViewModel: CellViewModelProtocol {
    var cellType: CellType = .story
    let imageURL: String?
    let title: String
    let author: String
}
