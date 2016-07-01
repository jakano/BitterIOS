//
//  TweetViewCell.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/28/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {
    var reTweets: [Tweet] = []
    
    var tweet: Tweet!
    var retweetCounter = 0
    var favoriteCounter = 0
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetCounterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(sender: AnyObject) {
        retweetCounter = tweet.retweetCount
        print(retweetCounter)
        retweetCounter += 1
        TwitterClient.sharedInstance.retweetCall(tweet.id!, success: {
            print("good job")
            self.retweetCounterLabel.text = String(self.retweetCounter)
        }) { (error: NSError) in
                print("error: \(error.localizedDescription) oh no")
        }
    }
    @IBAction func onFavorite(sender: AnyObject) {
        favoriteCounter = tweet.favoritesCount
        print(favoriteCounter)
        favoriteCounter += 1
        TwitterClient.sharedInstance.favoriteCall(tweet.id!, success: {
            self.favoriteLabel.text = String(self.favoriteCounter)
            print("got that fave")
        }) { (error: NSError) in
                print("error: \(error.localizedDescription)")
        }
    }
   
}
