//
//  ProductTableViewCell.swift
//  ProductsApp
//
//  Created by John Peter Pomperada on 2/12/26.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
   
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(productName: String, productDescription: String){
        
        productNameLabel.text = productName
        productDescriptionLabel.text = productDescription
    }
}
