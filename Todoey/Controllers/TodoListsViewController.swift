//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListsViewController: UITableViewController {
    
    let realm = try! Realm()
    var items:Results<Item>?
    
    var selectedCategory:Category? {
        didSet{
            getItems()
            navigationItem.title = selectedCategory?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListsView", for: indexPath)
        
        if let item = items?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isDone ? .checkmark : .none
        } else {
            cell.textLabel?.text = "Add your first item"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let item = items?[indexPath.row]{
            do{
                try realm.write({
                    item.isDone = !item.isDone
                })
            }catch {
                print("error in save item.isdone: \(error)")
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let text = textField.text, text != "" else {
                return
            }
            if let currentCategory = self.selectedCategory {
                    do{
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = text
                            newItem.isDone = false
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    }catch{
                        print("SaveItems Error: \(error)")
                    }
                    
                }
                self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new ToDo"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func getItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        
    }
    
}

extension TodoListsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            getItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            items = items?.filter(predicate).sorted(byKeyPath: "dateCreated", ascending: false)
        }
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        tableView.reloadData()
    }
}

