//
//  ComposeViewController.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/30/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//
import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var tweetMessageField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSendMessage(sender: AnyObject) {
        TwitterClient.sharedInstance.composeTweet(self.tweetMessageField.text, success: {
            print("sent")
            self.tweetMessageField.text = ""
            self.performSegueWithIdentifier("messagesent", sender: nil)
            
        }) { (error: NSError) in
            print("error:" )
            print(error.localizedDescription)
        }
    }
}