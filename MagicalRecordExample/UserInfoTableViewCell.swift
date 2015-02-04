//
//  UserInfoTableViewCell.swift
//  MagicalRecordExample
//
//  Created by moyan on 15-2-4.
//  Copyright (c) 2015年 moyan. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    
    var user : User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(user: User) {
        self.lblName.text = user.name
        self.lblAge.text = user.age.description + "岁"
        let df = NSDateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        self.lblBirthday.text = df.stringFromDate(user.birthday)
        self.user = user
    }

}
