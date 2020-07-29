//
//  Variant+CoreDataProperties.swift
//  
//
//  Created by Abhishek Kumar on 27/07/20.
//
//

import Foundation
import CoreData


extension Variant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Variant> {
        return NSFetchRequest<Variant>(entityName: "Variant")
    }

    @NSManaged public var id: Int16
    @NSManaged public var color: String?
    @NSManaged public var size: Int16
    @NSManaged public var price: Double
    @NSManaged public var product: Product?

}
