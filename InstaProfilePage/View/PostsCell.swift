//
//  PostsCell.swift
//  InstaProfilePage
//
//  Created by ali cihan on 7.09.2024.
//

import UIKit

class PostsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static var identifier = "PostsCell"
    var posts: [Post] = []
    var section: String?
    let itemSize = (UIScreen.main.bounds.size.width - 3) / 3
    var heightConstraint: NSLayoutConstraint!
    private var postsCollectionView: UICollectionView!
    
    private let loadingView: UIActivityIndicatorView = {
           let indicator = UIActivityIndicatorView(style: .large)
           indicator.color = .gray
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLoadingView()
    }
    
    func setupView() {
        let itemsLayout = UICollectionViewFlowLayout()
        itemsLayout.scrollDirection = .vertical
        itemsLayout.minimumLineSpacing = 1
        itemsLayout.minimumInteritemSpacing = 1
        postsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: itemsLayout)
        postsCollectionView.dataSource = self
        postsCollectionView.delegate = self
        postsCollectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        postsCollectionView.register(ReelCell.self, forCellWithReuseIdentifier: ReelCell.identifier)
        postsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        postsCollectionView.isScrollEnabled = false
        contentView.addSubview(postsCollectionView)
        
        
        heightConstraint = postsCollectionView.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([postsCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
                                     heightConstraint
                                    ])
    }
    
    func configure(data: [Post], section: String) {
        self.posts = data
        self.section = section
        updateHeight(section: section)
        postsCollectionView.reloadData()
        toggleLoadingView()
    }
    
    private func setupLoadingView() {
           contentView.addSubview(loadingView)
           NSLayoutConstraint.activate([
               loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
           ])
       }
    
    private func toggleLoadingView() {
        if posts.isEmpty {
            loadingView.startAnimating()
            postsCollectionView.isHidden = true
        } else {
            loadingView.stopAnimating()
            postsCollectionView.isHidden = false
        }
    }
    
    func updateHeight(section: String) {
        if section == "reels" {
            heightConstraint.isActive = false
            heightConstraint = postsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(posts.count / 3 + 1) * ( itemSize * (16/9) + 1))
            heightConstraint.isActive = true
        } else {
            heightConstraint.isActive = false
            heightConstraint = postsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(posts.count / 3 + 1) * (itemSize + 1))
            heightConstraint.isActive = true
        }
        postsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if section == "reels" {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelCell.identifier, for: indexPath) as? ReelCell else {
                fatalError("collectionview error")
            }
            cell.configure(data: posts[indexPath.row])
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
            fatalError("collectionview error")
        }
        cell.configure(data: posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = section == "reels" ? itemSize * (16/9) : itemSize
        return CGSize(width: itemSize, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Postscell fatal error")
    }
    
}
