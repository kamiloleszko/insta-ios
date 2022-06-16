//
//  ProfileController.swift
//  InstaTut
//
//  Created by kamil on 07/06/2022.
//

import UIKit

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "HeaderIdentifier"

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {collectionView.reloadData()}
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchUser()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser() { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(
            ProfileCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )
        
        collectionView.register(
            ProfileHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerIdentifier
        )
    }
}

// MARK: - UiCollectionDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        }
        return header
    }
}

//MARK: UiCollectionViewDelegate

extension ProfileController {
    
}

//MARK: - UiColelctionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3 // szerokosc podzielona na 3 (przy odjeciu 1px na margines pomiedzy zdjeciami -> ma byc 3 w rzedze z 1px odstepu od siebie
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

