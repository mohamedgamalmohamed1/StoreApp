//
//  mCell.swift
//  storeApp
//
//  Created by mohamed gamal mohamed on 6/2/19.
//  Copyright © 2019 mohamed gamal mohamed. All rights reserved.
//

import UIKit

class mCell: UITableViewCell {

    @IBOutlet weak var laItemName: UILabel!
    @IBOutlet weak var laimage: UIImageView!
    @IBOutlet weak var laDateAdded: UILabel!
    @IBOutlet weak var laStoreImage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func SetMyCell(item:Item){
        laStoreImage.text = item.item_name
        laimage.image = item.image as? UIImage
        laItemName.text = item.toStore?.name
        // Convert Date To string
        let dateformate = DateFormatter()
        dateformate.dateFormat = "DD/MM/yy   h:mm a"
        laDateAdded.text = dateformate.string(from: item.date_add as! Date)
    }

}
    
