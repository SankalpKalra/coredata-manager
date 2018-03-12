//
//  CoreDataManagerClass.swift
//  CoreDataManager
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManagerClass{
    
    class func getContext()->NSManagedObjectContext{
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
  
   class func saveCoreData()
   {
    do{
    let context = getContext()
    try context.save()
    
    }catch{
    
    }
    }
    
    class func save(entity:String)->NSManagedObject{

        let context = getContext()
       
        let entity=NSEntityDescription.entity(forEntityName: entity, in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
     return manageObject
    }
//    class func save(fName:String , lName:String , contactNumber:String , email:String , empId:String)->NSManagedObject{
//
//
//        let context = getContext()
//
//
//        let entity=NSEntityDescription.entity(forEntityName: "Employee", in: context)
//        let employeeObj = NSManagedObject(entity: entity!, insertInto: context)
//
//        employeeObj
//
//       manageObject.setValue(fName, forKey: "firstName")
//       manageObject.setValue(lName, forKey: "lastName")
//       manageObject.setValue(empId, forKey: "empId")
//       manageObject.setValue(contactNumber, forKey: "contactNumber")
//       manageObject.setValue(email, forKey: "email")
//
//        do{
//            try context.save()
//                return employeeObj
//        }catch{
//            return employeeObj
//        }
//
//    }
    
    class func fetch()->[Employee]{
        let context = getContext()
       
        var user:[Employee]?=nil
        do{
            user=try context.fetch(Employee.fetchRequest())
            return user!
        }catch{
            return user!
        }
        
    }
    
    class func delete(entity:String,empId:String){
        
        let context=getContext()
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do{
            let empData = try context.fetch(request) as? [Employee]
            for user in empData!{
                if empId == user.empId
                {
                    context.delete(user)
                }
            }
           try! context.save()
    }catch{
    print("NO DATA")
    }
    
}
    
    
    class func update(entity:String,empId:String?)->Employee?{
        
        let context=getContext()
        var xobj: Employee? //
        let request=NSFetchRequest<NSFetchRequestResult>(entityName:entity)
        do{
            let userData=try context.fetch(request) as! [Employee]
            if empId != nil{
            for obj in userData{
                if obj.empId==empId{
                    xobj = obj
                    return xobj
               }
            }
            }
//            else{
//                context.delete(xobj!)
//            }
            
        }catch{
            print("")
        }
        return xobj
    }
    
    
    
    
     class func deleteBatch(entity:String){
        let context=getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let delete = NSBatchDeleteRequest(fetchRequest:request)
        do{
            try context.execute(delete)
            self.saveCoreData()
        
        }catch{
            print("Error")
        }
        
        
        
        
    }
}
