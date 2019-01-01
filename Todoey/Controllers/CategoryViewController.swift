//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ravindra Kumar on 12/26/18.
//  Copyright © 2018 Ravindra Kumar. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    var realm = try! Realm()
    var categories : Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.separatorStyle = .none
       
    }
    
     // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
            if let category = categories?[indexPath.row]{
            
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        
        
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories add yet"
            cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "1D9BF6")
        

        return cell
    }

    

    // Mark: - Add new Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let  newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            self.saveCategories(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            print(alertTextField)
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try! self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
          
            }
            //tableView.reloadData()
        }
    }
        
    
    

    
    
     // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC =  segue.destination as! TodoListViewController
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
   
    
     // MARK: - TableView Manipulation Methods
    
    func saveCategories(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error in saving context \(error)")
        }
        tableView.reloadData()
        
    }
    
    
func loadCategories(){
      categories = realm.objects(Category.self)
        tableView.reloadData()
    }
}


















