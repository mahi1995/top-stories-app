//
//  HomeViewModel.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 07/06/2022.
//

import Foundation

struct TopStoryCellViewModel: CellViewModelProtocol {
    var cellType: CellType = .story
}

protocol HomePageProtocol: AnyObject {
    func didReceiveData()
}

class HomeViewModel {
    private var cells: [CellViewModelProtocol] = [EmptyCellViewModel()]
    weak var delegate: HomePageProtocol?
    init() {
        loadStories()
    }
    
    var cellCount: Int {
        return cells.count
    }
    
    func itemAt(indexPath: IndexPath) -> CellViewModelProtocol {
        return cells[indexPath.row]
    }
    
    func loadStories() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak self] in
            self?.cells = [TopStoryCellViewModel(), TopStoryCellViewModel()]
            self?.delegate?.didReceiveData()
        }
    }
}
