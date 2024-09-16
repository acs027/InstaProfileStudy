//
//  ViewController.swift
//  InstaProfilePage
//
//  Created by ali cihan on 7.09.2024.
//

import UIKit
import Combine

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var viewModel = ProfileViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var mainCollectionView: UIScrollView!
    var profileHeaderView: ProfileHeaderView!
    var editProfileButton: UIButton!
    var shareProfileButton: UIButton!
    var storiesCollectionView: UICollectionView!
    var segmentCollectionView: UICollectionView!
    var postsButton: UIButton!
    var shortsButton: UIButton!
    var savedButton: UIButton!
    var selectedBttnIndicator: UIView!
    var selectedBttnIndicatorContraint: NSLayoutConstraint!
    var maxHeight: CGFloat = 200
    
    var isReelsLoadTriggered = false
    var isSavedPostsLoadTriggered = false
    
    let itemSize = (UIScreen.main.bounds.size.width - 3) / 3
    
    var segmentHeigtConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetch(.posts)
        
        navigationController?.navigationBar.isHidden = true
        
        mainCollectionView = UIScrollView()
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.showsVerticalScrollIndicator = false
        mainCollectionView.bounces = false
        view.addSubview(mainCollectionView)
        mainCollectionView.contentSize = CGSize(width: view.bounds.width, height: 408)
        
        profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.addSubview(profileHeaderView)
        
        editProfileButton = UIButton()
        editProfileButton.setTitle("Edit profile", for: .normal)
        editProfileButton.setTitleColor(.black, for: .normal)
        editProfileButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.backgroundColor = .lightGray
        editProfileButton.layer.cornerRadius = 10
        mainCollectionView.addSubview(editProfileButton)
        
        shareProfileButton = UIButton()
        shareProfileButton.setTitle("Share profile", for: .normal)
        shareProfileButton.setTitleColor(.black, for: .normal)
        shareProfileButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        shareProfileButton.backgroundColor = .lightGray
        shareProfileButton.translatesAutoresizingMaskIntoConstraints = false
        shareProfileButton.layer.cornerRadius = 10
        mainCollectionView.addSubview(shareProfileButton)
        
        let storiesLayout = UICollectionViewFlowLayout()
        storiesLayout.minimumLineSpacing = 10
        storiesLayout.minimumInteritemSpacing = 1
        storiesLayout.scrollDirection = .horizontal
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: storiesLayout)
        storiesCollectionView.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.identifier)
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        storiesCollectionView.showsHorizontalScrollIndicator = false
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        mainCollectionView.addSubview(storiesCollectionView)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.imagePadding = 0
        buttonConfig.baseForegroundColor = .black
        
        postsButton = UIButton()
        postsButton.setImage(UIImage(systemName: "square.grid.3x3.fill"), for: .normal)
        postsButton.translatesAutoresizingMaskIntoConstraints = false
        postsButton.tag = 0
        postsButton.addTarget(self, action: #selector(segmentSelected(_:)), for: .touchUpInside)
        postsButton.configuration = buttonConfig
        mainCollectionView.addSubview(postsButton)
        
        shortsButton = UIButton()
        shortsButton.setImage(UIImage(systemName: "play.square"), for: .normal)
        shortsButton.translatesAutoresizingMaskIntoConstraints = false
        shortsButton.tag = 1
        shortsButton.configuration = buttonConfig
        shortsButton.addTarget(self, action: #selector(segmentSelected(_:)), for: .touchUpInside)
        mainCollectionView.addSubview(shortsButton)
        
        savedButton = UIButton()
        savedButton.setImage(UIImage(systemName: "person.crop.square"), for: .normal)
        savedButton.translatesAutoresizingMaskIntoConstraints = false
        savedButton.tag = 2
        savedButton.configuration = buttonConfig
        savedButton.addTarget(self, action: #selector(segmentSelected(_:)), for: .touchUpInside)
        mainCollectionView.addSubview(savedButton)
        
        selectedBttnIndicator = UIView()
        selectedBttnIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectedBttnIndicator.backgroundColor = .black
        mainCollectionView.addSubview(selectedBttnIndicator)
        
        selectedBttnIndicatorContraint = selectedBttnIndicator.centerXAnchor.constraint(equalTo: postsButton.centerXAnchor)
        selectedBttnIndicatorContraint.isActive = true
        
        let segmentLayout = UICollectionViewFlowLayout()
        segmentLayout.minimumLineSpacing = 0
        segmentLayout.minimumInteritemSpacing = 1
        segmentLayout.scrollDirection = .horizontal
        segmentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: segmentLayout)
        segmentCollectionView.register(PostsCell.self, forCellWithReuseIdentifier: PostsCell.identifier)
        segmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        segmentCollectionView.isPagingEnabled = true
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        segmentCollectionView.showsHorizontalScrollIndicator = false
        mainCollectionView.addSubview(segmentCollectionView)
        
        segmentHeigtConstraint = segmentCollectionView.heightAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                                     mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     
                                     profileHeaderView.topAnchor.constraint(equalTo: mainCollectionView.topAnchor),
                                     profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     profileHeaderView.heightAnchor.constraint(equalToConstant: 180),
                                     
                                     editProfileButton.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
                                     editProfileButton.leadingAnchor.constraint(equalTo: mainCollectionView.leadingAnchor, constant: 10),
                                     editProfileButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 30) / 2),
                                     editProfileButton.heightAnchor.constraint(equalToConstant: 35),
                                     
                                     shareProfileButton.topAnchor.constraint(equalTo: editProfileButton.topAnchor),
                                     shareProfileButton.leadingAnchor.constraint(equalTo: editProfileButton.trailingAnchor, constant: 10),
                                     shareProfileButton.widthAnchor.constraint(equalTo: editProfileButton.widthAnchor, multiplier: 1),
                                     shareProfileButton.heightAnchor.constraint(equalTo: editProfileButton.heightAnchor, multiplier: 1),
                                     
                                     storiesCollectionView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor),
                                     storiesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
                                     storiesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     storiesCollectionView.heightAnchor.constraint(equalToConstant: 120),
                                     
                                     postsButton.topAnchor.constraint(equalTo: storiesCollectionView.bottomAnchor, constant: 8),
                                     postsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     postsButton.widthAnchor.constraint(equalToConstant: itemSize),
                                     postsButton.heightAnchor.constraint(equalToConstant: 40),
                                     
                                     shortsButton.topAnchor.constraint(equalTo: postsButton.topAnchor),
                                     shortsButton.leadingAnchor.constraint(equalTo: postsButton.trailingAnchor),
                                     shortsButton.heightAnchor.constraint(equalTo: postsButton.heightAnchor, multiplier: 1),
                                     shortsButton.widthAnchor.constraint(equalTo: postsButton.widthAnchor, multiplier: 1),
                                     
                                     savedButton.topAnchor.constraint(equalTo: shortsButton.topAnchor),
                                     savedButton.leadingAnchor.constraint(equalTo: shortsButton.trailingAnchor),
                                     savedButton.heightAnchor.constraint(equalTo: shortsButton.heightAnchor, multiplier: 1),
                                     savedButton.widthAnchor.constraint(equalTo: shortsButton.widthAnchor, multiplier: 1),
                                     
                                     selectedBttnIndicator.topAnchor.constraint(equalTo: postsButton.bottomAnchor),
                                     selectedBttnIndicator.widthAnchor.constraint(equalTo: postsButton.widthAnchor, multiplier: 0.5),
                                     selectedBttnIndicator.heightAnchor.constraint(equalToConstant: 2),
                                     
                                     segmentCollectionView.topAnchor.constraint(equalTo: selectedBttnIndicator.bottomAnchor, constant: 10),
                                     segmentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     segmentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     segmentHeigtConstraint
                                    ])
    }
    
    private func bindViewModel() {
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateProfileView()
                self?.updateUI()
                self?.segmentCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$reels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateUI()
                self?.segmentCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$savedPosts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateUI()
                self?.segmentCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$stories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.storiesCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func updateTabBarItem(data: Post) {
        let image = UIImage(data: data.imgData)?.roundedImage(size: 30).withRenderingMode(.alwaysOriginal)
        self.tabBarItem = UITabBarItem(title: nil, image: image, tag: 4)
    }
    
    func updateProfileView() {
        if viewModel.posts.count > 0 {
            let profileData = self.viewModel.posts.first!
            self.profileHeaderView.configure(data: profileData, count: self.viewModel.posts.count)
            self.updateTabBarItem(data: profileData)
        }
    }
    
    func updateUI() {
        let postsHeight = CGFloat((viewModel.posts.count / 3) + 1) * (itemSize + 1)
        let reelsHeight = CGFloat((viewModel.reels.count / 3) + 1) * (itemSize * (16/9) + 1)
        let savedPostsHeight = CGFloat((viewModel.savedPosts.count / 3) + 1) * (itemSize + 1)
        self.maxHeight = max(postsHeight, reelsHeight, savedPostsHeight)
        mainCollectionView.contentSize.height = 408 + self.maxHeight
        
        segmentHeigtConstraint.isActive = false
        segmentHeigtConstraint = segmentCollectionView.heightAnchor.constraint(equalToConstant: maxHeight)
        segmentHeigtConstraint.isActive = true
        segmentCollectionView.reloadData()
        
    }
    
    @objc func segmentSelected(_ sender: UIButton) {
        segmentCollectionView.isPagingEnabled = false
        switch sender.tag {
        case 0:
            self.segmentCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        case 1:
            self.segmentCollectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        case 2:
            self.segmentCollectionView.scrollToItem(at: IndexPath(row: 2, section: 0), at: .centeredHorizontally, animated: true)
        default:
            return
        }
        segmentCollectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == segmentCollectionView {
            return 3
        }
        
        if collectionView == storiesCollectionView {
            
            if viewModel.stories.count > 1 {
                return viewModel.stories.count + 1
            } else {
                return 1
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.storiesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell else {
                fatalError("Story cell error")
            }
            
            if indexPath.row == 0 && viewModel.stories.count < 1 {
                cell.configure()
            } else if viewModel.stories.count > indexPath.row {
                cell.configure(data: viewModel.stories[indexPath.row])
            } else {
                cell.configure()
            }
            return cell
        }
        
        if IndexPath(item: 1, section: 0) == indexPath {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCell.identifier, for: indexPath) as? PostsCell else {
                fatalError("collectionview error")
            }
            cell.configure(data: viewModel.reels, section: "reels")
            return cell
        }
        
        if IndexPath(item: 2, section: 0) == indexPath {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCell.identifier, for: indexPath) as? PostsCell else {
                fatalError("collectionview error")
            }
            cell.configure(data: viewModel.savedPosts, section: "savedPosts")
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCell.identifier, for: indexPath) as? PostsCell else {
            fatalError("collectionview error")
        }
        cell.configure(data: viewModel.posts, section: "posts")
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.storiesCollectionView {
            return CGSize(width: 80, height: 80 * 1.5)
        }
        
        if collectionView == self.segmentCollectionView {
            if IndexPath(item: 1, section: 0) == indexPath {
                return CGSize(width: self.view.bounds.width, height: self.maxHeight)
            }
            
            else if IndexPath(item: 2, section: 0) == indexPath {
                return CGSize(width: self.view.bounds.width, height: self.maxHeight)
            }
            else {
                return CGSize(width: self.view.bounds.width, height: self.maxHeight)
            }
        }
        return CGSize(width: self.view.bounds.width, height: itemSize)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == segmentCollectionView {
            selectedBttnIndicatorContraint.isActive = false
            let offset = scrollView.contentOffset.x / 3
            selectedBttnIndicatorContraint = selectedBttnIndicator.centerXAnchor.constraint(equalTo: postsButton.centerXAnchor, constant: offset)
            selectedBttnIndicatorContraint.isActive = true
            
            if !isSavedPostsLoadTriggered {
                if scrollView.contentOffset.x > view.bounds.width {
                    viewModel.fetch(.savedPosts)
                    isSavedPostsLoadTriggered = true
                }
            }
            
            if !isReelsLoadTriggered {
                if scrollView.contentOffset.x > 0 {
                    viewModel.fetch(.reels)
                    isReelsLoadTriggered = true
                }
            }
            
        }
    }
}

