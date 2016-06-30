//
//  JSONTools.swift
//  MovieDB
//
//  Created by Jordan Aldujaili on 5/13/16.
//  Copyright © 2016 Jordan . All rights reserved.
//

import Foundation

protocol Archivable {
    var JSONForm: AnyObject {get}
    init?(JSONObject: AnyObject)
}
