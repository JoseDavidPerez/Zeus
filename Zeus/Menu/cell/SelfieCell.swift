//
//  SelfieCell.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import UIKit

class SelfieCell: UITableViewCell {

    @IBOutlet weak var imagenView: UIImageView!
    public var camaraImage : UIImage?{
        didSet{
            imagenView.image = camaraImage
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
