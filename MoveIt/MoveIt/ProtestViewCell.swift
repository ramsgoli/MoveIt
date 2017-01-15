//
//  ProtestViewCell.swift
//  MoveIt
//
//  Created by Lawrence Chen on 1/14/17.
//  Copyright © 2017 Lawrence Chen. All rights reserved.
//

import UIKit

class ProtestViewCell: UITableViewCell {
    @IBOutlet var protestName: UILabel!
    @IBOutlet var locationName: UILabel!
    @IBOutlet var date: UILabel!
    var idString = ""
    @IBOutlet var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
