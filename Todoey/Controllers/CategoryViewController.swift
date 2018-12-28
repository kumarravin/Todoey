//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ravindra Kumar on 12/26/18.
//  Copyright © 2018 Ravindra Kumar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategories()
    }
     // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "CategotyCell", for: indexPath)
        let category =  categories[indexPath.row]
        cell.textLabel?.text = category.name
       // cell.accessoryType = category.done ? .checkmark : .none
        return cell
    }
    

    // Mark: - Add new Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let  newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            //newCategory.done = false
            self.categories.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            print(alertTextField)
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        context.delete(categories[indexPath.row])
//        categories.remove(at: indexPath.row)
//        saveCategories()
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    
    
     // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC =  segue.destination as! TodoListViewController
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
   
    
     // MARK: - TableView Manipulation Methods
    
    func saveCategories(){
        
        do {
            try context.save()
        } catch {
            print("Error in saving context \(error)")
        }
        tableView.reloadData()
        
    }
    
    
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error in fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}
