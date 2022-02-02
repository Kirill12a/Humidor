//
//  Sigars+CoreDataProperties.swift
//  
//
//  Created by Kirill Drozdov on 02.02.2022.
//
//

import Foundation
import CoreData


extension Sigars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sigars> {
        return NSFetchRequest<Sigars>(entityName: "Sigars")
    }

    @NSManaged public var date: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var place: String?

}
