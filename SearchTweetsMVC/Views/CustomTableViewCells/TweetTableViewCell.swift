//
//  TweetTableViewCell.swift
//  SearchTweetsMVC
//
//  Created by Shibili Areekara on 02/03/19.
//  Copyright © 2019 Shibili Areekara. All rights reserved.
//


import UIKit

class TweetTableViewCell : UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleAndCreatedAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var tweetImageViewHeightConstraint: NSLayoutConstraint!
    private var defaultTweetImageViewHeightConstraint: CGFloat!
    
    var tweet: Tweets? { didSet { updateUI() } }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if tweetImageViewHeightConstraint != nil && defaultTweetImageViewHeightConstraint != nil {
            tweetImageViewHeightConstraint.constant = defaultTweetImageViewHeightConstraint
        }
    }
    
    private func updateUI() {
        
        self.initialiseValues()
        
        self.updateLabels()
        
        self.updateProfileImageView()
        
        self.updateTweetImageView()
    }
    
    private func initialiseValues() {
        profileImageView?.image = nil
        tweetImageView?.image = nil
    }
    
    private func updateLabels() {
        
        tweetTextLabel?.text = tweet?.text ?? ""
        fullNameLabel?.text = tweet?.user?.name ?? ""
        handleAndCreatedAtLabel?.text = "@\(tweet?.user?.screen_name ?? "")"
        
        self.updateHandleAndCreatedAt()
        
        retweetButton.setTitle(" \(tweet?.retweet_count ?? 0)" , for: .normal)
        likeButton.setTitle(" \(tweet?.favorite_count ?? 0)" , for: .normal)
    }
    
    private func updateHandleAndCreatedAt () {
        
        if let created = tweet?.created_at {
            
            if let createdDate = twitterDateFormatter.date(from: created) {
            
                let createdText = createdDate.getFormattedDateString()
                handleAndCreatedAtLabel?.text = "@\(tweet?.user?.screen_name ?? "") • \(createdText)"
            }
        }
    }
    
    
    private func updateProfileImageView () {
        
        if let profileImageURL = tweet?.user?.profile_image_url {
            self.profileImageView.loadImageFromUrl(urlString: profileImageURL)
        }
    }
    
    private func updateTweetImageView () {
        
        if let mediaItem = tweet?.entities?.media {
            if let mediaURL = mediaItem.first?.media_url_https {
                self.tweetImageView.loadImageFromUrl(urlString: mediaURL)
                
            } else {
                self.updateForNoTweetImage()
            }
        } else {
            self.updateForNoTweetImage()
        }
    }
    
    private func updateForNoTweetImage () {
        tweetImageView?.image = nil
        defaultTweetImageViewHeightConstraint = tweetImageViewHeightConstraint.constant
        tweetImageViewHeightConstraint.constant = 0
        layoutIfNeeded()
    }
    
    private let twitterDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

private extension UIView
{
    func roundedCorners(cRadius:CGFloat = 5.0) {
        self.layer.cornerRadius = cRadius
        layer.masksToBounds = true
    }
}

extension Date {
    func getFormattedDateString() -> String {
        let formatter = DateFormatter()
        if Date().timeIntervalSince(self) > 24*60*60 {
            formatter.dateStyle = .short
        } else {
            formatter.timeStyle = .short
        }
        return formatter.string(from: self)
    }
}





