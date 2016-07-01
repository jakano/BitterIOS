//
//  TwitterClient.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/27/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "EdyYDKem4IItlgnf8gnhpewES", consumerSecret: "eWTReNDyORyGp3OEH07ZYELwBqxIKY9tmRUS5qOqTaOemgw5Q9")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimline(success: ([Tweet]) ->(), failure: NSError -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {
            (task: NSURLSessionDataTask, response: AnyObject?) in
                let dictionairies = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionairies)
                success(tweets)
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                    failure(error)
        })
    }
    func retweetCall(tweetID: Int, success: () -> (), failure: NSError -> ()) {
        POST("1.1/statuses/retweet/\(tweetID).json", parameters: ["id": tweetID], progress: nil, success: {
            (task: NSURLSessionDataTask, response: AnyObject?) in
             success()
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
    }
    func favoriteCall(tweetID: Int, success: () -> (), failure: NSError -> ()) {
        POST("1.1/favorites/create.json", parameters: ["id": tweetID], progress: nil, success: {
            (task: NSURLSessionDataTask, response: AnyObject?) in
            success()
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
    }
    func composeTweet(status: String, success: () -> (), failure: NSError -> ()) {
        POST("1.1/statuses/update.json", parameters: ["status": status], progress: nil, success: {
            (task: NSURLSessionDataTask, response: AnyObject?) in
            success()
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
    }


    
    
    
    func currentUser(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
            print("name: \(user.name)")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
                print("error: \(error.localizedDescription)")
        })

    }
    
    func login(success: ()->(), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "Bitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
            print("I got a token")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
        }) { (error: NSError!) in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }

    }
    func logOut() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    func handelOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            self.currentUser({ (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
                    print("Error: \(error)")
            })
            print("I got access token")
            
        }) { (error: NSError!) in
            self.loginFailure?(error)
            print("error: \(error.localizedDescription)")
        }
        
    }
}
        