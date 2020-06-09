//
//  ToDoCategories+CoreDataProperties.swift
//  Todoey
//
//  Created by Yasser on 2020-06-09.
//  Copyright © 2020 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoCategories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoCategories> {
        return NSFetchRequest<ToDoCategories>(entityName: "ToDoCategories")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for categoryToItems
extension ToDoCategories {

    @objc(addCategoryToItemsObject:)
    @NSManaged public func addToCategoryToItems(_ value: ToDoItems)

    @objc(removeCategoryToItemsObject:)
    @NSManaged public func removeFromCategoryToItems(_ value: ToDoItems)

    @objc(addCategoryToItems:)
    @NSManaged public func addToCategoryToItems(_ values: NSSet)

    @objc(removeCategoryToItems:)
    @NSManaged public func removeFromCategoryToItems(_ values: NSSet)

}
