//
//  ProfileHeaderView.swift
//  InstaProfile
//
//  Created by ali cihan on 4.09.2024.
//

import UIKit

class ProfileHeaderView: UIView {
    var profileTypeIcon: UIImageView!
    var profileTitle: UIButton!
    var createButton: UIButton!
    var hamButton: UIButton!
    
    var profileImageView: UIImageView!
    var userNameLabel: UILabel!
    var bioLabel: UILabel!
    var postsLabel: UILabel!
    var followersLabel: UILabel!
    var followingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileTypeIcon = UIImageView()
        profileTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        profileTypeIcon.image = UIImage(systemName: "lock.fill")
        profileTypeIcon.contentMode = .scaleAspectFit
        profileTypeIcon.tintColor = .black
        addSubview(profileTypeIcon)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.imagePadding = 0
        buttonConfig.baseForegroundColor = .black
        buttonConfig.titleLineBreakMode = .byTruncatingTail
        
        profileTitle = UIButton(type: .system)
        profileTitle.setTitle("", for: .normal)
        profileTitle.translatesAutoresizingMaskIntoConstraints = false
        profileTitle.configuration = buttonConfig
        profileTitle.contentHorizontalAlignment = .left
        addSubview(profileTitle)
        
        createButton = UIButton(type: .system)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        createButton.contentMode = .scaleAspectFit
        createButton.configuration = buttonConfig
        addSubview(createButton)
        
        hamButton = UIButton(type: .system)
        hamButton.translatesAutoresizingMaskIntoConstraints = false
        hamButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        hamButton.contentMode = .scaleAspectFit
        hamButton.configuration = buttonConfig
        addSubview(hamButton)
        
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
        
        NSLayoutConstraint.activate([
            
            profileTypeIcon.topAnchor.constraint(equalTo: topAnchor),
            profileTypeIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileTypeIcon.widthAnchor.constraint(equalToConstant: 20),
            
            profileTitle.centerYAnchor.constraint(equalTo: profileTypeIcon.centerYAnchor),
            profileTitle.leadingAnchor.constraint(equalTo: profileTypeIcon.trailingAnchor),
            profileTitle.widthAnchor.constraint(equalToConstant: 150),
            
            hamButton.centerYAnchor.constraint(equalTo: profileTitle.centerYAnchor),
            hamButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            hamButton.widthAnchor.constraint(equalToConstant: 40),
            
            createButton.centerYAnchor.constraint(equalTo: hamButton.centerYAnchor),
            createButton.trailingAnchor.constraint(equalTo: hamButton.leadingAnchor),
            createButton.widthAnchor.constraint(equalTo: hamButton.widthAnchor, multiplier: 1),
            
            
            
            profileImageView.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 10),
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
            postsLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,constant: 20),
            postsLabel.widthAnchor.constraint(equalToConstant: 80),
            postsLabel.heightAnchor.constraint(equalToConstant: 80),
            
            followersLabel.topAnchor.constraint(equalTo: postsLabel.topAnchor),
            followersLabel.leadingAnchor.constraint(equalTo: postsLabel.trailingAnchor, constant: 8),
//            followersLabel.widthAnchor.constraint(equalToConstant: 80),
            followersLabel.trailingAnchor.constraint(equalTo: followingLabel.leadingAnchor, constant: -8),
            followersLabel.heightAnchor.constraint(equalToConstant: 80),
            
            followingLabel.topAnchor.constraint(equalTo: followersLabel.topAnchor),
            followingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            followingLabel.widthAnchor.constraint(equalToConstant: 80),
            followingLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure(data: Post, count: Int) {
        profileImageView.image = UIImage(data: data.imgData)
        userNameLabel.text = data.description
        bioLabel.text = data.title
        //        profileTitle.setTitle(data.description, for: .normal)
        let boldTitle = NSAttributedString(string: data.description, attributes: [ .font: UIFont.preferredFont(forTextStyle: .headline)])
        profileTitle.setAttributedTitle(boldTitle, for: .normal)
        postsLabel.attributedText = makeAttributedString(title: count.description, subtitle: "posts")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init had not been implemented")
    }
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        titleString.append(subtitleString)
        return titleString
    }
    
}
