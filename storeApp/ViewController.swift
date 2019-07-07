//
//  ViewController.swift
//  storeApp
//
//  Created by mohamed gamal mohamed on 6/2/19.
//  Copyright © 2019 mohamed gamal mohamed. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , NSFetchedResultsControllerDelegate{
    
    var controller:NSFetchedResultsController<Item>!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        LoadItems()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections =  controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects

        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // row is selected
        if let objc = controller.fetchedObjects{
            let item = objc[indexPath.row]
            performSegue(withIdentifier: "EditOrDelete", sender: item)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="EditOrDelete"{
            if let destination = segue.destination as? AddItemViewController{
                if let item = sender as? Item{
                    destination.EditOrDeleteItem = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show cell code
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! mCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    func configureCell(cell:mCell , indexPath:IndexPath){
        let Singleitem = controller.object(at: indexPath)
        cell.SetMyCell(item: Singleitem)
    }
    
    func LoadItems(){
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        let date_addSort = NSSortDescriptor(key: "date_add", ascending: false)
        fetchRequest.sortDescriptors = [date_addSort]
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        do{
            try controller.performFetch()
        }
        catch{
            print("Error")
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       // data fetch
        switch (type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
                configureCell(cell : cell as! mCell,indexPath:indexPath as IndexPath)
                
            }
            break
        case.move:
        if let indexPath = indexPath {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if let indexPath = newIndexPath {
            tableView.insertRows(at: [indexPath], with: .fade)
    }
        break
}
    }
    
}
