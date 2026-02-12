//
//  ViewController.swift
//  ProductsApp
//
//  Created by John Peter Pomperada on 2/12/26.
//

import UIKit



class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var productModel : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let urlString = "https://dummyjson.com/products"
        fetchData(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let products):
                self?.productModel = products
                DispatchQueue.main.async{ [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("ERROR \(error)")

            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showProductDetails" {
            let destinationVC = segue.destination as? ProductDetailsViewController
            
            destinationVC?.productDetails = sender as? Product
            
        }
    }
    
    // MARK: FUNCTIONS
    func fetchData(urlString: String, completionHandler: @escaping (Result<[Product], Error>) -> Void ){
        let url = URL(string: urlString)
        guard let unwrappedUrl = url else {return}
        let urlRequest = URLRequest(url: unwrappedUrl)
        
        URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            if let err = error {
                completionHandler(.failure(err))
            }
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "Error object is nil", code: -1)))
                return
            }
            
            do {
                let productModel = try JSONDecoder().decode(Products.self, from: data)
                print(productModel)
                completionHandler(.success(productModel.products))
            } catch {
                print("Error decoding: \(error)")
                
            }
        }.resume()
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productModel.count
        
        //return 1
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as? ProductTableViewCell
        
        //cell.bind(productName: String, productDescription: <#T##String#>)
        
        cell?.bind(productName: productModel[indexPath.row].title, productDescription: productModel[indexPath.row].description)
        
        cell?.delegate = self // delegate is view controller
        return cell ?? UITableViewCell()
        
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        //print(productModel[indexPath.row].productName)
        let productDetails = productModel[indexPath.row]
        performSegue(withIdentifier: "showProductDetails", sender: productDetails)
    }
}

extension ViewController: ProductTableViewCellDelegate {
    func showAddToCartSuccess(productName: String) {
        let alertController = UIAlertController(title: "Add to Cart Success!", message: "\(productName) added to cart", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Got It!", style: .default) {
            [weak self] _ in guard let self else {return}
            dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}
