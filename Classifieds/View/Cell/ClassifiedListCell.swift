//
//  HomeListCell.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

protocol ClassifiedsListable {
    var title: String { get }
    var subTitle: String { get }
    func loadImage(imageView: UIImageView?)
}

class ClassifiedListCell: UICollectionViewCell {
    
    @IBOutlet private (set) weak var imageView: UIImageView?
    @IBOutlet private (set) weak var labelTitle: UILabel?
    @IBOutlet private (set) weak var labelSubTitle: UILabel?
    
    var item: ClassifiedsListable? {
        didSet {
            configure(list: item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setupViews()
    }
    
    // TODO: Implement Image loading from url
    private func configure(list: ClassifiedsListable?) {
        labelTitle?.text = list?.title
        labelSubTitle?.text = list?.subTitle
        imageView?.image = nil
        guard let imageview = imageView else { return }
        list?.loadImage(imageView: imageview)
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
