//
//  AddItemViewController.swift
//  storeApp
//
//  Created by mohamed gamal mohamed on 6/2/19.
//  Copyright © 2019 mohamed gamal mohamed. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    var ListStoreType = [StoreType]()
    var imagePicker:UIImagePickerController!

    @IBOutlet weak var pvStoreType: UIPickerView!
    @IBOutlet weak var ivToolImage: UIImageView!
    @IBOutlet weak var txtToolName: UITextField!
    var EditOrDeleteItem:Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        pvStoreType.dataSource = self
        pvStoreType.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        LoadStores()
        if EditOrDeleteItem != nil {
            LoadForEdit()
        }
    }
    func LoadStores (){
        let fetchRequest:NSFetchRequest<StoreType> = StoreType.fetchRequest()
        do { ListStoreType = try context.fetch(fetchRequest)
        }
        catch{
            
        }
    }
    // start picker view impelement
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ListStoreType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = ListStoreType[row]
        return store.name
    }
    // end picker view impelement
    
    @IBAction func BuBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // IMPELEMENT IMAGE PICKER
    
    
    @IBAction func BuSelectImage(_ sender: Any) {
        present( imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            ivToolImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    // END IMPELEMENT IMAGE PICKER

    @IBAction func BuSave(_ sender: Any) {
        let newItem:Item!
        if EditOrDeleteItem == nil{
            newItem = Item(context: context)
        }else{
            newItem = EditOrDeleteItem
        }
        newItem.item_name = txtToolName.text
        newItem.date_add = NSDate() as Date
        newItem.image = ivToolImage.image
        newItem.toStore = ListStoreType[pvStoreType.selectedRow(inComponent: 0)]
        do{
            ad.saveContext()
            txtToolName.text = ""
            print("saved")
        }
        catch{
            print("error")
        }
    }
    
    func LoadForEdit(){
        if let item = EditOrDeleteItem{
            txtToolName.text = item.item_name
            ivToolImage.image = item.image as? UIImage
            if let store = item.toStore{
                var index = 0
                while index<ListStoreType.count{
                    let row = ListStoreType[index]
                    if row.name == store.name{
                        pvStoreType.selectRow(index, inComponent: 0, animated: false)
                    }
                    index = index+1
                }
            }
        }
        
    }
    
    @IBAction func BuDelete(_ sender: Any) {
        if EditOrDeleteItem == nil{
            context.delete(EditOrDeleteItem!)
            ad.saveContext()
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        }
    }
}
