//
//  ArticleViewController.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var seeMoreLabel: UILabel! {
        didSet {
            seeMoreLabel.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target:self,action:#selector(onTapSeeMoreLabel))
            seeMoreLabel.addGestureRecognizer(tapGesture)
        }
    }
    let viewModel: ArticleViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ArticleViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        authorLabel.text = viewModel.author
        dateLabel.text = viewModel.date
        loadingIndicator.isHidden = true
        if let image = viewModel.image {
            imageView.image = image
        } else {
            guard let urlString = viewModel.imageURL, let url = URL(string: urlString) else {
                imageView.image = UIImage(named: "placeholder_image")
                return
            }
            imageView.loadImage(from: url) { _ in }
        }
        seeMoreLabel.attributedText = viewModel.seeMoreAttributedString
    }
    
    @objc func onTapSeeMoreLabel() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        RemoteArticleLoader().getArticle(with: viewModel.url) { _ in
            
        }
    }
}
