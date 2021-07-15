//
//  PrestViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class PrestViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tarifLabel: UILabel!
    
    var Prest:PrestStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = Prest?.nom
        catLabel.text = Prest?.nomCat
        descriptionLabel.text = Prest?.description
        tarifLabel.text = Prest?.tarif
        
        
        let urlString = "http://localhost:3000/img/"+(Prest?.photo)!
        let url = URL(string: urlString)
        
        imageView.downloaded(from: url!)
        print(Prest?.photo as Any)
    }
    


}
