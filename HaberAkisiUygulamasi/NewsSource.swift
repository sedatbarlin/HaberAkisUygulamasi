//
//  NewsSource.swift
//  HaberAkisiUygulamasi
//
//  Created by resedat on 4.05.2022.
//

import Foundation

class Source:Codable {
    
    var name:String?
    
    init() {
    }
    
    init(name:String) {
        self.name = name
    }
}
