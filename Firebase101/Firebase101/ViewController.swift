//
//  ViewController.swift
//  Firebase101
//
//  Created by meng on 2021/03/11.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var numOfCustomers: UILabel!
    @IBOutlet weak var firstData: UILabel!
    
    let db = Database.database().reference()
    var customers:[Customer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLabel()
        saveBasicTypes()
//        saveCustomers()
        fetchCustomers()
//        updateBasicTypes()
//        deleteBasicTypes()
    }
    // MARK: 데이터 가져오기
    func updateLabel(){
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.firstData.text = value
            }
        }
    }
    
    @IBAction func createCustomer(_ sender: UIButton) {
        saveCustomers()
    }
    
    @IBAction func fetchCustomer(_ sender: UIButton) {
        fetchCustomers()
    }
    
    @IBAction func updateCustomer(_ sender: UIButton) {
        updateCustomers()
    }
    
    @IBAction func deleteCustomer(_ sender: UIButton) {
        deleteCustomers()
    }
}

// MARK: 데이터 저장
extension ViewController{
    // MARK: 데이터 베이직 저장 방법
    func saveBasicTypes(){
        db.child("int").setValue(3)
        db.child("double").setValue(3.5)
        db.child("str").setValue("string value - 여러분 안녕")
        db.child("dict").setValue(["id": "anyID", "age": 10, "city": "seoul"])
    }
    // MARK: 데이터 커스텀 저장 방법
    func saveCustomers(){
        let books = [Book(title: "Good to Great", author: "Someone"), Book(title: "Hackiing Growth", author: "Somebody")]
        let customer1 = Customer(id: "\(Customer.id)", name: "Son", books: books)
        Customer.id += 1
        let customer2 = Customer(id: "\(Customer.id)", name: "Dele", books: books)
        Customer.id += 1
        let customer3 = Customer(id: "\(Customer.id)", name: "Kane", books: books)
        Customer.id += 1
        
        db.child("customers").child(customer1.id).setValue(customer1.toDictionary)
        db.child("customers").child(customer2.id).setValue(customer2.toDictionary)
        db.child("customers").child(customer3.id).setValue(customer3.toDictionary)
    }
}


// MARK: 파싱방법
extension ViewController{
    func fetchCustomers(){
        db.child("customers").observeSingleEvent(of: .value) { (snapshot) in
            //print("--> \(snapshot)")
            do{
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let decoder = JSONDecoder()
                let customers: [Customer] = try decoder.decode([Customer].self, from: data)
                self.customers = customers
                DispatchQueue.main.async {
                    self.numOfCustomers.text = "Num of customers : \(customers.count)"
                }
            } catch {
                print("---> \(error.localizedDescription)")
            }
        }
    }
}


// MARK: 수정 및 삭제
extension ViewController{
    func updateBasicTypes(){
        db.updateChildValues(["int": 6])
        db.updateChildValues(["double": 5.4])
        db.updateChildValues(["str": "변경된스트링임"])
    }
    
    func updateCustomers(){
        guard customers.isEmpty == false else {
            return
        }
        customers[0].name = "Min"
        let dictionary = customers.map { $0.toDictionary }
        db.updateChildValues(["customers": dictionary])
    }
    
    func deleteBasicTypes(){
        db.child("int").removeValue()
        db.child("double").removeValue()
        db.child("str").removeValue()
    }
    
    func deleteCustomers(){
        db.child("customers").removeValue()
    }
}


struct Customer: Codable {
    let id: String
    var name: String
    let books: [Book]
    
    var toDictionary: [String: Any]{
        let booksArray = books.map{ $0.toDictionary }
        let dict: [String: Any] = ["id": id, "name": name, "books": booksArray]
        return dict
    }
    static var id: Int = 0
}

struct Book: Codable {
    let title: String
    let author: String
    
    var toDictionary: [String: Any]{
        let dict: [String: Any] = ["title": title, "author": author]
        return dict
    }
}
