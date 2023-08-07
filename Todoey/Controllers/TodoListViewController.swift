//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

            
//        loadItem()
    }

    
    //MARK: - TableView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        var item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType =  item.done == true ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Method
    //Method trigger whenever we click on item in tableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var item = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
           
            
            let toDo = Item(context: context)
            toDo.title = item.text ?? ""
            toDo.done = false
            self.itemArray.append(toDo)
            
            self.saveItems()
        
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            item  = alertTextField   
           
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    
   func saveItems(){

       
       do{
           try context.save()
       }
       catch{
           print("Error saving the context \(error)")
       }
       
       self.tableView.reloadData()
       
       
       //
//        let encoder = PropertyListEncoder()
//
//        do{
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
//            }
//        catch{
//            print("error is \(error)")
//        }
//
//        self.tableView.reloadData()
    }
    
    
//    func loadItem(){
//        if let safeData = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//              itemArray = try decoder.decode([Item].self, from: safeData)
//
//            }
//            catch{
//                print("Error while decoding \(error)")
//            }
//
//
//        }
//
//    }
    
}

