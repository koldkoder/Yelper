//
//  YelperBusinessTableViewCell.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/20/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//

import UIKit

class YelperBusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessDistanceLabel: UILabel!
    @IBOutlet weak var businessCategoryLabel: UILabel!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    var business: YelperRepo! {
        didSet {
            businessNameLabel.text = business.name!
            businessAddressLabel.text = business.address!
            businessCategoryLabel.text = business.categories?.joinWithSeparator(",")
            reviewsCountLabel.text = "\(business.reviewsCount!) Reviews"
            businessImageView.setImageWithURL(business.imageUrl!)
            ratingsImageView.setImageWithURL(business.ratingImageUrl!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
