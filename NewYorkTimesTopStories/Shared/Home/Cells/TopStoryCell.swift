//
//  TopStoryCell.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

class TopStoryCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: self.superview?.frame.width ?? containerView.frame.width,
                      height: containerView.frame.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.grey60.cgColor
        containerView.renderShadow()
    }
}
