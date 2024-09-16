//
//  ShortCell.swift
//  InstaProfilePage
//
//  Created by ali cihan on 10.09.2024.
//

import UIKit

class ReelCell: UICollectionViewCell {
    static var identifier = "ReelCell"
    
    var post: Post?
    var imageView: UIImageView!
    var reelIcon: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        let itemSize = (UIScreen.main.bounds.size.width - 3) / 3
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: itemSize * (16 / 9)),
            imageView.widthAnchor.constraint(equalToConstant: itemSize)
        ])
    }
    
    func configure(data: Post) {
        self.post = data
        
        imageView.image = UIImage(data: data.imgData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Reel Cell fatal error")
    }
    
}
