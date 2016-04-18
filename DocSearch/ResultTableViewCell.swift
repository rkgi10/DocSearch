//
//  ResultTableViewCell.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 15/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import Foundation

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formatLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var downloadButton : UIButton!
    
    var formats = ["Images","PDFs","MS-Office Documents"]
    var bgcolors = [
        UIColor(red: 37/255, green: 198/255, blue: 218/255, alpha: 1.0),
        UIColor(red: 76/255, green: 182/255, blue: 172/255, alpha: 1.0),
        UIColor(red: 129/255, green: 198/255, blue: 131/255, alpha: 1.0),
        UIColor(red: 174/255, green: 213/255, blue: 130/255, alpha: 1.0)
    ]
    
    var randomNum = Int(arc4random_uniform(4))
    var document : Document!{
        didSet{
            self.formatLabel.text = document.format.uppercaseString
            self.formatLabel.textColor = bgcolors[randomNum]
            self.nameLabel.text = document.name
            self.authorLabel.text = "by " + document.author
            self.dateLabel.text = "Uploaded in " + "\(document.yearUploaded)"
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
