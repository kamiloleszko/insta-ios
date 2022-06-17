//
//  MainTabController.swift
//  InstaTut
//
//  Created by kamil on 07/06/2022.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    private var user: User? {
        didSet{
            guard let user = user else {return}
            configureViewController(withUser: user)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        
        }
    }
    
    func fetchUser() {
        UserService.fetchUser() { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    // MARK: - Helpers
    
    func configureViewController(withUser user: User) {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(
            unselectedImage: UIImage(imageLiteralResourceName: "home_unselected"),
            selectedImage: UIImage(imageLiteralResourceName: "home_selected"),
            rootViewController: FeedController(collectionViewLayout: layout)
        )
        
        let search = templateNavigationController(
            unselectedImage: UIImage(imageLiteralResourceName: "search_unselected"),
            selectedImage: UIImage(imageLiteralResourceName: "search_selected"),
            rootViewController: SearchController()
        )
        
        let imageSelector = templateNavigationController(
            unselectedImage: UIImage(imageLiteralResourceName: "plus_unselected"),
            selectedImage: UIImage(imageLiteralResourceName: "plus_unselected"),
            rootViewController: ImageSelectorcontroller()
        )
        
        let notification = templateNavigationController(
            unselectedImage: UIImage(imageLiteralResourceName: "like_unselected"),
            selectedImage: UIImage(imageLiteralResourceName: "like_selected"),
            rootViewController: NotificationController()
        )
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(
            unselectedImage: UIImage(imageLiteralResourceName: "profile_unselected"),
            selectedImage: UIImage(imageLiteralResourceName: "profile_selected"),
            rootViewController: profileController
        )
        
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        
        viewControllers = [feed, search, imageSelector, notification, profile]
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    	
}


// MARK: - AuthenticationDelegate

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

