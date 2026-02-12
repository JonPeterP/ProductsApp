//
//  ViewController.swift
//  ProductsApp
//
//  Created by John Peter Pomperada on 2/12/26.
//

import UIKit

struct Products {
    let productName: String
    let productDescription: String
    
}

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var productModel : [Products] = [
        Products(productName: "Apple Macbook Pro", productDescription: "Latest generation model"),
        Products(productName: "iPhone 17 Pro Max Fully Paid", productDescription: "Latest iPhone"),
        Products(productName: "Samsung Galaxy 1", productDescription: "Ew")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productModel.count
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as? ProductTableViewCell
        
        //cell.bind(productName: String, productDescription: <#T##String#>)
        
        cell?.bind(productName: productModel[indexPath.row].productName, productDescription: productModel[indexPath.row].productDescription)
        
        return cell ?? UITableViewCell()
        
    }
}



