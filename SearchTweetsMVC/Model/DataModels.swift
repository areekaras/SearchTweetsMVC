//
//  DataModels.swift
//  SearchTweetsMVC
//
//  Created by Shibili Areekara on 02/03/19.
//  Copyright © 2019 Shibili Areekara. All rights reserved.
//


import Foundation
import UIKit


public struct SearchResult: Decodable {
    let statuses: [Tweets]?
}

public struct Tweets: Decodable {
    let text:String?
    let created_at:String?
    let favorite_count:Int?
    let retweet_count:Int?
    
    let user: UserDetail?
    
    let entities: Entities?
}

public struct UserDetail: Decodable {
    let name:String?
    let screen_name:String?
    let id_str:String?
    let profile_image_url:String?
}

public struct Entities: Decodable {
    let media: [Media]?
}

public struct Media: Decodable{
    let media_url_https:String?
}




