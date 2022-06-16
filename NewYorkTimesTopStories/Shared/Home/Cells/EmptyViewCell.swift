//
//  EmptyViewCell.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

class EmptyViewCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    weak var delegate: HomeCellDelegate?
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: self.superview?.frame.width ?? containerView.frame.width,
                      height: self.superview?.frame.height ?? containerView.frame.height)
    }
    
    func configure(with viewModel: CellViewModelProtocol) {
        guard let viewModel = viewModel as? EmptyCellViewModel else { return }
        informationLabel.text = viewModel.informationMessage
    }
}
