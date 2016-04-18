//
//  FormatTableViewCell.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 14/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

class FormatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var format : UILabel!
    var formatString : String! {
        didSet{
            self.format.text = formatString.uppercaseString
            format.textColor = UIColor.whiteColor()
            print(formatString)
        }
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
