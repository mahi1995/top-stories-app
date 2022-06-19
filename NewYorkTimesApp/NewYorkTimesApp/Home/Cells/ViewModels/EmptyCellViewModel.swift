//
//  EmptyCellViewModel.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

struct EmptyCellViewModel: CellViewModelProtocol {
    var cellType: CellType = .empty
    var informationMessage: String
}
