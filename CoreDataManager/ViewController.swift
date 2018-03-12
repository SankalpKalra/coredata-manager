//
//  ViewController.swift
//  CoreDataManager
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var user:[Employee]?=nil
    @IBOutlet weak var firsttName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var empId: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var contactNumber: UITextField!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        self.clear()
    }
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        self.saveData()
    }
    
    @IBAction func fetchBtnTapped(_ sender: UIButton) {
        self.getData()
    }
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        self.dropData()
    }
    
    
    @IBAction func updateBtnTapped(_ sender: UIButton) {
        self.updateData()
    }
    
    @IBAction func deleteBatchBtnTapped(_ sender: UIButton) {
        self.dropWholeData()
    }
    
    func clear()
    {
        
        firsttName.text=""
        lastName.text=""
        email.text=""
        empId.text=""
        contactNumber.text=""
    }
    
    func saveData(){
        
        let emp=CoreDataManagerClass.save(entity: "Employee") as! Employee
        
        emp.firstName=self.firsttName.text ?? ""
        emp.lastName=self.lastName.text ?? ""
        emp.email=self.email.text ?? ""
        emp.contactNumber=self.contactNumber.text ?? ""
        emp.empId=self.empId.text ?? ""
        CoreDataManagerClass.saveCoreData()
        
        self.outputLabel.text="Data Saved"
        
        clear()
        
        //        CoreDataManagerClass.save(fName: "Sankalp", lName: "Kalra", contactNumber: "9711855555", email: "kalrasankalp84@gmail.com", empId: "AI417")
    }
    
    func getData(){
        //var user:[Employee]?=nil
        user = CoreDataManagerClass.fetch()
        print(user!.count)
       
        if empId.text==""{
            self.outputLabel.text="**Enter Employee Id**"
        }
            
        else{
            for emp in user!{
                //            print(emp.firstName ?? "Nothing")
                //            print(emp.lastName ?? "Nothing")
                //            print(emp.empId ?? "Nothing")
                //            print(emp.email ?? "Nothing")
                //            print(emp.contactNumber ?? "Nothing")
                //
                if empId.text==emp.empId{
                    
                    self.firsttName.text=emp.firstName
                    self.lastName.text=emp.lastName
                    self.empId.text=emp.empId
                    self.contactNumber.text=emp.contactNumber
                    self.email.text=emp.email
                    
                    self.outputLabel.text="Data Fetched"
                    break
                    // CoreDataManagerClass.saveCoreData()
                    
                }
                else{
                    self.outputLabel.text="No Data Found"
                }
            }
        }
        
    }
    
    
    func dropData(){
        CoreDataManagerClass.delete(entity: "Employee",empId:empId.text!)
        self.outputLabel.text="Data Deleted"
    }
    
    func dropWholeData()
    {
        CoreDataManagerClass.deleteBatch(entity: "Employee")
        self.outputLabel.text="Data Schema Deleted"
    }
    
    func updateData(){
        let row = CoreDataManagerClass.update(entity: "Employee", empId: empId.text!)
        
        if self.empId.text! == "" {
            self.outputLabel.text="*Enter EmpId to Update*"
        }
        else{
            //if self.empId.text! == row?.empId {
                if (firsttName.text! == "" || lastName.text! == "" || email.text! == "" || contactNumber.text! == ""){
                    self.outputLabel.text="No field can be left Blank"
                }
               
                else{
                    row?.firstName=self.firsttName.text
                    row?.contactNumber=self.contactNumber.text
                    row?.email=self.email.text
                    row?.lastName=self.lastName.text
                    self.clear()
                    self.outputLabel.text="Data Updated"
                    CoreDataManagerClass.saveCoreData()
                }
            }
        
        
    }
    
}

