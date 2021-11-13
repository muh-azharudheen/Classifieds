//
//  HomeListCell.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

class HomeListCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var labelTitle: UILabel?
    @IBOutlet private weak var labelSubTitle: UILabel?
    
    var list: List? {
        didSet {
            configure(list: list)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setupViews()
    }
    
    // TODO: Implement Image loading from url
    private func configure(list: List?) {
        labelTitle?.text = list?.title
        labelSubTitle?.text = list?.subtitle
        imageView?.loadImage(with: list?.thumbNailURL)
    }
    
    private func setupViews() {
        
        labelTitle?.font = CFont.quickSand.font(with: 16)
        labelTitle?.textColor = .primaryDark
        labelSubTitle?.font = CFont.quickSand.font(with: 12)
        labelSubTitle?.textColor = .primaryLight
        
        imageView?.layer.cornerRadius = 10
        imageView?.layer.masksToBounds = true
    }
}
