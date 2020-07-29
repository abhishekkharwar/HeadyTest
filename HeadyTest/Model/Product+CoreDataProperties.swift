//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Ashok Mahawar on 27/07/20.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var dateAdded: String?
    @NSManaged public var category: Product?
    @NSManaged public var varients: NSSet?

}

// MARK: Generated accessors for varients
extension Product {

    @objc(addVarientsObject:)
    @NSManaged public func addToVarients(_ value: Varient)

    @objc(removeVarientsObject:)
    @NSManaged public func removeFromVarients(_ value: Varient)

    @objc(addVarients:)
    @NSManaged public func addToVarients(_ values: NSSet)

    @objc(removeVarients:)
    @NSManaged public func removeFromVarients(_ values: NSSet)

}
