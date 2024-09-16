//
//  StoryCell.swift
//  InstaProfile
//
//  Created by ali cihan on 5.09.2024.
//

import UIKit

class StoryCell: UICollectionViewCell {
    static var identifier = "StoryCell"
    
    var outerRingView: UIView!
    var imageView: UIImageView!
    var label: UILabel!
    var imageSize: CGFloat = 70
    let outerRingSize: CGFloat = 78
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        outerRingView = UIView()
        outerRingView.frame = CGRect(x: outerRingSize/2, y: outerRingSize/2, width: outerRingSize, height: outerRingSize)
        outerRingView.backgroundColor = .clear
        outerRingView.layer.cornerRadius = outerRingSize / 2
        outerRingView.layer.masksToBounds = true
        outerRingView.layer.borderWidth = 2
        outerRingView.layer.borderColor = UIColor.black.cgColor
        outerRingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(outerRingView)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "New"
        label.font = .systemFont(ofSize: 14)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            outerRingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            outerRingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            outerRingView.heightAnchor.constraint(equalToConstant: outerRingSize),
            outerRingView.widthAnchor.constraint(equalToConstant: outerRingSize),
            
            label.centerXAnchor.constraint(equalTo: outerRingView.centerXAnchor),
            label.topAnchor.constraint(equalTo: outerRingView.bottomAnchor)
            
        ])
    }
    
    func loadImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: (outerRingSize - imageSize) / 2, y: (outerRingSize - imageSize) / 2, width: imageSize, height: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        outerRingView.addSubview(imageView)
        
        
        NSLayoutConstraint.activate([     imageView.centerXAnchor.constraint(equalTo: outerRingView.centerXAnchor),
                                          imageView.centerYAnchor.constraint(equalTo: outerRingView.centerYAnchor),
                                          imageView.heightAnchor.constraint(equalToConstant: imageSize),
                                          imageView.widthAnchor.constraint(equalToConstant: imageSize)])
    }
    
    func configure(data: Post) {
        imageSize = 70
        loadImageView()
        imageView.image = UIImage(data: data.imgData)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        label.text = data.title.components(separatedBy: " ").first
    }
    
    func configure() {
        imageSize = 30
        loadImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Story cell error!")
    }
    
}
