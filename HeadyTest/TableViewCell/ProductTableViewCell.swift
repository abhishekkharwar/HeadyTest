//
//  UserTableViewCell.swift
//  AngelBTestCode
//
//  Created by Abhishek Kumar on 27/04/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        avtarImageView.layer.cornerRadius = avtarImageView.frame.size.width / 2
    }
    
}
