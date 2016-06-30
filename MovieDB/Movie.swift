//
//  Movie.swift
//  MovieDB
//
//  Created by Jordan  on 5/2/16.
//  Copyright © 2016 Jordan . All rights reserved.
//

import UIKit

struct Movie{
    struct Keys {
        static let Title = "title"
        static let Overview = "overview"
        static let Poster = "poster_path"
        static let ID = "id"
    }
    
    var title = ""
    var id = 0
    var overview = ""
    var poster: String? = nil
    
    init(dictionary: [String :AnyObject]){
        title = dictionary[Keys.Title] as! String
        overview = dictionary[Keys.Overview] as! String
        poster = dictionary[Keys.Poster] as? String
        id = dictionary[Keys.ID] as! Int
        
    }
    
}

extension Movie : Archivable {
    
    var JSONForm: AnyObject {
        get {
            var d: [String : AnyObject] = [
                Keys.Title : self.title,
                Keys.ID : self.id,
                Keys.Overview : self.overview
            ]
            
            if let path = poster {
                d[Keys.Poster] = path
            }
            
            return d
        }
    }
    
    init?(JSONObject: AnyObject) {
        
        guard let dictionary = JSONObject as? [String : AnyObject],
            title = dictionary[Keys.Title] as? String,
            id = dictionary[Keys.ID] as? Int,
            overview = dictionary[Keys.Overview] as? String
            else {
                return nil
        }
        
        self.title = title
        self.id = id
        self.overview = overview
        
        poster = dictionary[Keys.Poster] as? String
    }
}

