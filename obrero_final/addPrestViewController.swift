//
//  addPrestViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire

class addPrestViewController: UIViewController {

    //create liste
   
    @IBOutlet weak var prestNom: UITextField!
    @IBOutlet weak var prestDescription: UITextView!
    @IBOutlet weak var prestCat: UITextField!
    @IBOutlet weak var prestTarif: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        Register()
    }
    
   
    func Register(){
        
        let idu = UserDefaults.standard.object(forKey: "idUser") as? Int;
        let x = String(idu!)
        print(x)
        
        
        let parameters = ["nom": prestNom.text!,"description": prestDescription.text!, "nomCat": prestCat.text!,"tarif":prestTarif.text!]
        AF.request("http://localhost:3000/prestation/"+x, method: .post,  parameters: parameters as Parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json["message"] as! String)
                            let msg = json["message"] as! String
                            if(msg == "login successfull"){
                            
                                
                                  //  self.performSegue(withIdentifier: "addphone", sender: self)
                            //    self.performSegue(withIdentifier: "toUpload", sender: self)
                                print("hello")
                                
                            }
                            else {
                                self.createAlert(title: "Failed", message: msg)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
        
        
    }
    
    func createAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    }


