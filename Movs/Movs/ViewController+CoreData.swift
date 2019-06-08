//
//  View+Table+Collection+CoreData.swift
//  Movs
//
//  Created by Gustavo Evangelista on 07/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController{
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
