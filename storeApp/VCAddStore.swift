//
//  VCAddStore.swift
//  storeApp
//
//  Created by mohamed gamal mohamed on 6/2/19.
//  Copyright © 2019 mohamed gamal mohamed. All rights reserved.
//

import UIKit

class VCAddStore: UIViewController {

    @IBOutlet weak var txtStoreName: UITextField!
    @IBOutlet weak var BuSAve: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BuSAve.layer.borderWidth = 1.5
        BuSAve.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        BuSAve.layer.cornerRadius = 8
    }
    
    @IBAction func BuSave(_ sender: Any) {
        let store = StoreType(context: context)
        store.name = txtStoreName.text
        do {
            ad.saveContext()
            txtStoreName.text = ""
            print("SAved")
        }
        catch{
            print("CAnnot save")
        }
    }
    
    @IBAction func BuBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
