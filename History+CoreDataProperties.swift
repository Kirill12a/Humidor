//
//  History+CoreDataProperties.swift
//  
//
//  Created by Kirill Drozdov on 06.02.2022.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var name: String?
    @NSManaged public var shop: String?
    @NSManaged public var imageSigar: Data?
    @NSManaged public var review: String?

}
