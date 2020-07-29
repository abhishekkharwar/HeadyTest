//
//  Varient+CoreDataProperties.swift
//  
//
//  Created by Ashok Mahawar on 27/07/20.
//
//

import Foundation
import CoreData


extension Varient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Varient> {
        return NSFetchRequest<Varient>(entityName: "Varient")
    }

    @NSManaged public var id: Int16
    @NSManaged public var color: String?
    @NSManaged public var size: Int16
    @NSManaged public var price: Double
    @NSManaged public var product: Product?

}
