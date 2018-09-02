//
//  Chainage+CoreDataProperties.swift
//  
//
//  Created by Quang Le Nguyen on 29/8/18.
//
//

import Foundation
import CoreData


extension Chainage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chainage> {
        return NSFetchRequest<Chainage>(entityName: "Chainage")
    }

    @NSManaged public var long: String?
    @NSManaged public var lat: String?
    @NSManaged public var chainage: String?

}
