//
//  FilterCell.swift
//  Agent
//
//  Created by Ibrahim on 21/11/2024.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var picker: RoundUIView!
    @IBOutlet weak var lblFilter: SubTitleLBL!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func drawCell(_ item:String,selected:Bool) {
        picker.backgroundColor = selected ? .filterBack:.white
        picker.borderColor = .filterBorder
        picker.borderWidth = 2
        lblFilter.text = item
    }
}
