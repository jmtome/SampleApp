//
//  PostViewModel.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 11/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import UIKit

class PostViewModel {
    var post: Post
    var comments: [Comment]?
    
    init(post: Post) {
        self.post = post
    }
    
    func populatePost(with comments: [Comment]) {
        self.comments = comments.filter { (comment) -> Bool in
            comment.postId == self.post.id
        }
    }
    
}
