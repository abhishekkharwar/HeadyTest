//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Abhishek Kumar on 27/07/20.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int16
    @NSManaged public var viewCount: Double
    @NSManaged public var shareCount: Double
    @NSManaged public var orderCount: Double
    @NSManaged public var name: String?
    @NSManaged public var dateAdded: String?
    @NSManaged public var category: Product?
    @NSManaged public var variants: NSSet?

}

// MARK: Generated accessors for variants
extension Product {

    @objc(addVariantsObject:)
    @NSManaged public func addToVariants(_ value: Variant)

    @objc(removeVariantsObject:)
    @NSManaged public func removeFromVariants(_ value: Variant)

    @objc(addVariants:)
    @NSManaged public func addToVariants(_ values: NSSet)

    @objc(removeVariants:)
    @NSManaged public func removeFromVariants(_ values: NSSet)

}
