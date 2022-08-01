//
//  TextFieldCell.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBOutlet weak var txtfCell: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtfCell.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func isValid(text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z]", options: [])
        return regex.firstMatch(in: text, options: [], range: range) != nil
        
    }
}
extension TextFieldCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            print("While entering the characters this method gets called")
        return isValid(text: string);
        
    }
    
    
}
