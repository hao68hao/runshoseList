//
//  RunShoseRecord+CoreDataProperties.swift
//  RunShoseRecord
//
//  Created by lauda on 16/9/6.
//  Copyright © 2016年 lauda. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RunShoseRecord {

    @NSManaged var shoseName: String
    @NSManaged var shoseBrand: String?
    @NSManaged var shosePrice: String?
    @NSManaged var shoseImage: NSData
    @NSManaged var shoseBuyTime: String
    @NSManaged var shoseType: String
    @NSManaged var shoseProfile: String?
    @NSManaged var shoseBuyURL: String?
    @NSManaged var shoseUseTime: String?
    @NSManaged var shoseComment: String?
    @NSManaged var shoseLocation: String
    @NSManaged var shoseFav: NSNumber?
    @NSManaged var favShose: String?

}
