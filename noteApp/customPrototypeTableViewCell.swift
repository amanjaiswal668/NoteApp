//
//  customPrototypeTableViewCell.swift
//  noteApp
//
//  Created by Aman Jaiswal on 20/10/20.
//

import UIKit

class customPrototypeTableViewCell: UITableViewCell {
    
    //    MARK: - Creating IBOutlets.
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
