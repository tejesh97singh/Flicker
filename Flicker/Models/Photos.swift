//
//  Photos.swift
//  Flicker
//
//  Created by Tejesh Singh on 30/06/22.
//

import Foundation

struct Photos : Codable {
    let page,pages,perpage,total : Int?
    let photo : [Photo]?
    
    
}
