//
//  Tweet.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/27/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit
import PrettyTimestamp

class Tweet: NSObject {
    var text: String?
    var timeStamp: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User!
    var id: Int?
   
    
    init(dictionairy: NSDictionary){
        text = dictionairy["text"] as? String
        retweetCount = (dictionairy["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionairy["favorite_count"] as? Int) ?? 0
        let timeStampString = dictionairy["created_at"] as? String
        if timeStampString == timeStampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "E MMM d HH:mm:ss Z y"
            let nsDateStamp = formatter.dateFromString(timeStampString!)
            let prettyTimestamp = nsDateStamp?.prettyTimestampSinceNow()
            timeStamp = prettyTimestamp
            
        }
        id = (dictionairy["id"] as? Int) ?? 0
        let userDictionary = dictionairy["user"] as? NSDictionary
        user = User(dictionary: userDictionary!)
        
    }
    class func tweetsWithArray (dictionairies: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionaiary in dictionairies {
            let tweet = Tweet(dictionairy: dictionaiary)
            tweets.append(tweet)
        }
        return tweets
    }
    

}
