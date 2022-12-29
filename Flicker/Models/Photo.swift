//
//  Photo.swift
//  Flicker
//
//  Created by Tejesh Singh on 30/06/22.
//

import Foundation

struct Photo: Codable{
    let id, owner, secret,server, title : String?
    let  farm, ispublic, isfriend, isfamily : Int?
    var imageURL: String{
        let urlString = String(format: Constants.imageURL, farm!, server!, id!, secret!)
        return urlString
    }

}
