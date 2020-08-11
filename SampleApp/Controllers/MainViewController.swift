//
//  ViewController.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    //MARK: - Network Manager
    var networkManager = NetworkManager()
    
    //MARK: - Reuse Identifiers
    var reuseIdentifier = "UserCellId"
    
    //MARK: Properties
    var userProfiles: [UserViewModel] = [UserViewModel]()
    
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavCon()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Only make the network requests to populate the userProfiles if the array is empty
        if userProfiles.count == 0 {
            makeNetworkRequests()
        }
    }
}

//MARK: - Private Functions
extension MainViewController {
    
    //Network Fetch Request Methods
    private func makeNetworkRequests() {
        //Fetch users
        networkManager.fetchRequest(Constants.usersURL) { (result: Result<[User], NetworkError>) in
            switch result {
            case .success(let successValue):
                let users = successValue
                self.userProfiles = users.map({ (user) -> UserViewModel in
                    return UserViewModel(user: user)
                })
                //When the users are set, Fetch user posts and photos
                self.fetchPosts()
                
                self.userProfiles.forEach { (profile) in
                    self.fetchPhotos(for: profile)
                }
                //On the main thread we update the UI with whatever data we got at the moment, which at this point is at least the userlist and their posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //Fetch posts
    private func fetchPosts() {
        networkManager.fetchRequest(Constants.postsURL) { (result: Result<[Post], NetworkError>) in
            switch result {
            case .success(let successValue):
                //When the posts return successfully, we populate the userProfiles with posts
                let posts = successValue
                
                let postsVM = posts.map { (post) -> PostViewModel in
                    return PostViewModel(post: post)
                }
                self.userProfiles.forEach { (profile) in
                    profile.populateUser(with: postsVM)
                    
                }
                //After that, we fetch the comments for the posts
                self.fetchComments()
            case .failure(let error):
                print(error)
            }
        }
    }
    //Fetch comments
    private func fetchComments() {
        networkManager.fetchRequest(Constants.commentsURL) { (result: Result<[Comment], NetworkError>) in
            switch result {
            case .success(let successValue):
                let comments = successValue
                //populate posts with comments
                self.userProfiles.forEach { (profile) in
                    profile.posts?.forEach({ (post) in
                        post.populatePost(with: comments)
                    })
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //TODO: - Maybe this should allbe part of the networkmanager, but given I have to reload the tableview I'm doing it here
    //We fetch the photos in a background thread and when that request is done, we reload the tableview in the main thread
    private func fetchPhotos(for profile: UserViewModel) {
        DispatchQueue.global(qos: .background).async {
            let url = Constants.photosURL + "\(profile.user.id)"
            self.networkManager.fetchUserImage(with: url) { data in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)!
                    profile.setProfileImage(image)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: - UI Setup Methods
extension MainViewController {
    //MARK: - Setup NavCon
    func setupNavCon() {
        navigationItem.title = "Users"
    }
    //MARK: - Setup TV
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.register(UserCell.self, forCellReuseIdentifier: self.reuseIdentifier)
    }
}

//MARK: - Table view data source
extension MainViewController {
    
   //Number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfiles.count
    }
    
    // Create cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! UserCell
        
        let profile = userProfiles[indexPath.row]
        
        cell.userProfile = profile
        return cell
    }
   
    // Set row height according to section and cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: - TableView Delegate
extension MainViewController {
    //Actions when a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let profile = userProfiles[indexPath.row]
        
        let profileViewController = ProfileViewController()
        profileViewController.userProfile = profile
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
