//
//  HomeViewModel.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 07/06/2022.
//

import Foundation

protocol HomePageProtocol: AnyObject {
    func onLoadingData()
    func didReceiveData()
}

class HomeViewModel {
    private var cells: [CellViewModelProtocol] = [EmptyCellViewModel()]
    weak var delegate: HomePageProtocol?
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
        loader.getTopStories(completion: { response in
            
        })
    }
}
