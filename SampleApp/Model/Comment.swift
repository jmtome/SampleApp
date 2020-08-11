//
//  Comment.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

/*{
   "postId": 85,
   "id": 423,
   "name": "assumenda iure a",
   "email": "Oscar@pearline.com",
   "body": "rerum laborum voluptas ipsa enim praesentium\nquisquam aliquid perspiciatis eveniet id est est facilis\natque aut facere\nprovident reiciendis libero atque est"
 }*/
