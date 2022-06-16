//
//  LoadingIndicatorCell.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

class LoadingIndicatorCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: self.superview?.frame.width ?? containerView.frame.width,
                      height: self.superview?.frame.height ?? containerView.frame.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator.startAnimating()
    }
    
    deinit {
        loadingIndicator.stopAnimating()
    }
    
    func configure(with viewModel: CellViewModelProtocol) {}
}
