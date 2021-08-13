//
//  ArticleTableViewCell.swift
//  TribalScale
//
//  Created by Jack Bordner on 8/13/21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //TODO: Add border styling to containerView
    
    public func configure(article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author
        timestampLabel.text = String(article.publishedTimeStamp ?? 0)
        
        styleContainerView()
    }
    
    private func styleContainerView() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        containerView.layer.cornerRadius = 1
    }
}
