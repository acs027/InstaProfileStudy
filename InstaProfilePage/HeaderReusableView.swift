//
//  HeaderReusableView.swift
//  InstaProfilePage
//
//  Created by ali cihan on 7.09.2024.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    var profileImageView: UIImageView!
    var userNameLabel: UILabel!
    var bioLabel: UILabel!
    var postsLabel: UILabel!
    var followersLabel: UILabel!
    var followingLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(systemName: "person.crop.circle")
        addSubview(profileImageView)
        
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        userNameLabel.text = "username"
        addSubview(userNameLabel)
        
        bioLabel = UILabel()
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.font = UIFont.systemFont(ofSize: 14)
        bioLabel.textColor = .darkGray
        bioLabel.numberOfLines = 0
        bioLabel.text = "bio section text"
        addSubview(bioLabel)
        
        postsLabel = UILabel()
        postsLabel.translatesAutoresizingMaskIntoConstraints = false
        postsLabel.font = UIFont.systemFont(ofSize: 18)
        postsLabel.textAlignment = .center
        postsLabel.numberOfLines = 0
        postsLabel.attributedText = makeAttributedString(title: "99", subtitle: "posts")
        addSubview(postsLabel)
        
        followersLabel = UILabel()
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        followersLabel.font = UIFont.systemFont(ofSize: 18)
        followersLabel.textAlignment = .center
        followersLabel.numberOfLines = 0
        followersLabel.attributedText = makeAttributedString(title: "99", subtitle: "followers")
        addSubview(followersLabel)
        
        followingLabel = UILabel()
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        followingLabel.font = UIFont.systemFont(ofSize: 18)
        followingLabel.textAlignment = .center
        followingLabel.numberOfLines = 0
        followingLabel.attributedText = makeAttributedString(title: "99", subtitle: "following")
        addSubview(followingLabel)
        
        NSLayoutConstraint.activate([profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 36),
                                     profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     profileImageView.widthAnchor.constraint(equalToConstant: 80),
                                     profileImageView.heightAnchor.constraint(equalToConstant: 80),
                                     
                                     userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
                                     userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                     
                                     bioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
                                     bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                     
                                     postsLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                                     postsLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,constant: 8),
                                     postsLabel.widthAnchor.constraint(equalToConstant: 80),
                                     postsLabel.heightAnchor.constraint(equalToConstant: 80),
                                     
                                     followersLabel.topAnchor.constraint(equalTo: postsLabel.topAnchor),
                                     followersLabel.leadingAnchor.constraint(equalTo: postsLabel.trailingAnchor, constant: 8),
                                     followersLabel.widthAnchor.constraint(equalToConstant: 80),
                                     followersLabel.heightAnchor.constraint(equalToConstant: 80),
                                     
                                     followingLabel.topAnchor.constraint(equalTo: followersLabel.topAnchor),
                                     followingLabel.leadingAnchor.constraint(equalTo: followersLabel.trailingAnchor, constant: 8),
                                     followingLabel.widthAnchor.constraint(equalToConstant: 80),
                                     followingLabel.heightAnchor.constraint(equalToConstant: 80)
                                    ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init had not been implemented")
    }
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        titleString.append(subtitleString)
        return titleString
    }

}
