//
//  ToDoItems+CoreDataProperties.swift
//  Todoey
//
//  Created by Yasser on 2020-06-09.
//  Copyright © 2020 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItems> {
        return NSFetchRequest<ToDoItems>(entityName: "ToDoItems")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var title: String?
    @NSManaged public var category: ToDoCategories?

}
