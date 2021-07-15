//
//  ListPrestViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire



class ListPrestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
 
  
    
    //var
    var catNameTitle : String?
    var tabs : String?
    var posts:NSMutableArray = []
    var Prest:NSMutableArray = []
    var Heroes = [PrestStats]()

    var type:String?
    var userId = ""
    
 
    
    
    @IBOutlet weak var nomDeCat: UILabel!
    

  
    @IBOutlet weak var tableView: UITableView!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        nomDeCat.text = catNameTitle!

        downloadJson {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cmpCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        let imgView = contentView?.viewWithTag(2) as! UIImageView
        
        label.text = Heroes[indexPath.row].nom.capitalized
         //   let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
       
        let urlString = "http://localhost:3000/img/"+Heroes[indexPath.row].photo
        
        
        let url = URL(string: urlString)
        
        imgView.downloaded(from: url!)
    
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPrest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PrestViewController {
            destination.Prest = Heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    func downloadJson(completed: @escaping () -> ()) {
        let url = URL(string: "http://localhost:3000/prestations/"+catNameTitle!)
        
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if error == nil {
                
                do{
                    self.Heroes = try JSONDecoder().decode([PrestStats].self, from: data!)
                    print(self.Heroes.count)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                }
                catch{
                   
                    print("Json error")
                }
            }}.resume()
        
    }

}
