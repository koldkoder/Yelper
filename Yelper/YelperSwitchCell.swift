//
//  YelperSwitchCell.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/20/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: YelperSwitchCell, didChangeValue value: Bool)
}

class YelperSwitchCell: UITableViewCell {

    
    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    weak var delegate: SwitchCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        print("switch value changed")
        delegate?.switchCell?(self, didChangeValue: onSwitch.on)
    }

}
