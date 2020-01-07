//
//  TableViewCell2.swift
//  reservUTTiOS
//
//  Created by edifixio on 24/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit

class TableViewCell2: UITableViewCell {
    @IBOutlet weak var salleName: UILabel!
    @IBOutlet weak var salleType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
