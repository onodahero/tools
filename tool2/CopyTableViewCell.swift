//
//  CopyTableViewCell.swift
//  tool2
//
//  Created by 斧田洋人 on 2018/05/24.
//  Copyright © 2018年 斧田洋人. All rights reserved.
//

import UIKit

protocol CellDelegate: class {
    func copy(_ cell: CopyTableViewCell)
}

class CopyTableViewCell: UITableViewCell {

    var delegate: CellDelegate?
    @IBOutlet weak var copyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func copyButton(_ sender: Any) {
        delegate?.copy(self)
        print("button")
    }
    
    
}
