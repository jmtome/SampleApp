//
//  Post.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation

struct Post: Codable {
    //userId is the same as the 'id' field in User
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

/*{
   "userId": 10,
   "id": 92,
   "title": "ratione ex tenetur perferendis",
   "body": "aut et excepturi dicta laudantium sint rerum nihil\nlaudantium et at\na neque minima officia et similique libero et\ncommodi voluptate qui"
 }*/
