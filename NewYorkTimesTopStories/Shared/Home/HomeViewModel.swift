//
//  HomeViewModel.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 07/06/2022.
//

import Foundation

struct HomeViewModel {
    private var cells: [CellViewModelProtocol] = [EmptyCellViewModel()]
    var cellCount: Int {
        return cells.count
    }
    
    func itemAt(indexPath: IndexPath) -> CellViewModelProtocol {
        return cells[indexPath.row]
    }
}
