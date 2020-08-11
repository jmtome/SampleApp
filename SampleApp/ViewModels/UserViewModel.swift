//
//  UserViewModel.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import UIKit

class UserViewModel {
    var user: User
    var posts: [PostViewModel]? = nil
    var userImage: UIImage! = UIImage(systemName: "star.fill")
    
    init(user: User) {
        self.user = user
    }
    
    func setProfileImage(_ image: UIImage) {
        self.userImage = image
        
    }
    func populateUser(with posts: [PostViewModel]) {
        self.posts = assignPostsToUser(with: self.user.id, posts)
    }
    
    private func assignPostsToUser(with id: Int,_ posts: [PostViewModel]) -> [PostViewModel] {
        return posts.filter { (postVM) -> Bool in
            postVM.post.userId == id
        }
    }
}
