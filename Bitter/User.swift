//
//  User.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/27/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var info: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUlString = dictionary["profile_image_url_https"] as? String
        if let profileUlString = profileUlString {
            profileUrl = NSURL(string: profileUlString)!
        }
        info = dictionary["description"] as? String
        
    }
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentUserData") as? NSData
            if let userData = userData {
                let dictionairy = try!
                    NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionairy)
            }
                
            }
            return _currentUser
        } set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
            let data =  try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
//            defaults.setObject(user, forKey: "currentUser")
            defaults.synchronize()
        }
    }
    class func usersWithArray (dictionairies: [NSDictionary]) -> [User] {
        var users = [User]()
        for dictionaiary in dictionairies {
            let user = User(dictionary: dictionaiary)
            users.append(user)
        }
        return users
    }

}