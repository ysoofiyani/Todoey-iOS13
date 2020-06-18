//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Yasser on 2020-06-09.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


class CategoryTableViewController: TodoyTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     getCategories()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTVCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "Not Category add yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "categoryToItemsPage", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let category = categories?[indexPath.row]{
            if editingStyle == .delete {
                do {
                    try realm.write {
                        realm.delete(category)
                    }
                } catch {
                    print(error)
                }
                
            }
               }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    override func deleteCell(at indexPath: IndexPath) {
        if let category = categories?[indexPath.row]{
            do {
                try realm.write {
                    realm.delete(category)
                }
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let text = textField.text, text != "" else {
                return
            }
                let newCategory = Category()
                newCategory.name = text
                self.save(category: newCategory)
                self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - CoreData Functions
    
    func save(category:Category) {
        do{
            try realm.write({
                realm.add(category)
            })
        }catch{
            
        }
    }
    
    func getCategories() {
           categories = realm.objects(Category.self)
    }
    
}
