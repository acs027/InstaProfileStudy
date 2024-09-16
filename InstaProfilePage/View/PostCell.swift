//
//  PostCell.swift
//  InstaProfilePage
//
//  Created by ali cihan on 7.09.2024.
//

import UIKit

class PostCell: UICollectionViewCell {
    static var identifier = "PostCell"
    
    var post: Post?
    var imageView: UIImageView!
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
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: itemSize),
            imageView.widthAnchor.constraint(equalToConstant: itemSize)
        ])
    }
    
    func configure(data: Post) {
        self.post = data
        
        imageView.image = UIImage(data: data.imgData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Post cell fatal error")
    }
    
}
