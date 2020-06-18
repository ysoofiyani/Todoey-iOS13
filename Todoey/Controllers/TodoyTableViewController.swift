//
//  TodoyTableViewController.swift
//  Todoey
//
//  Created by Yasser on 2020-06-16.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class TodoyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70.0
        

    
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, complitionHandeler) in
            self.deleteCell(at: indexPath)
               }
               deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash.fill")
               
               let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
               return configuration
    }
    
    func deleteCell(at indexPath: IndexPath){}
    
    

}
