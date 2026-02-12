//
//  ProductTableViewCell.swift
//  ProductsApp
//
//  Created by John Peter Pomperada on 2/12/26.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func showAddToCartSuccess(productName: String)
}
class ProductTableViewCell: UITableViewCell {
   
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    weak var delegate: ProductTableViewCellDelegate?
    
    var productNameText: String  = ""{
        didSet{
            productNameLabel.text = productNameText
        }
    }
    var productDescriptionText: String = ""{
        didSet {
            productDescriptionLabel.text = productDescriptionText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(productName: String, productDescription: String){
        
        productNameText = productName
        productDescriptionText = productDescription
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
        delegate?.showAddToCartSuccess(productName: productNameText)
    }
    
}
