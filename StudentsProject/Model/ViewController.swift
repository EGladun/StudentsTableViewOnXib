//
//  ViewController.swift
//  StudentsProject
//
//  Created by Egor on 18.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    //MARK: Variables and constants
    var students: [Student] = []
    var searchStudents = [Student]()
    var searching = false
    var choosenStudent: Student?
    var currentProfile: String? = "https://www.yandex.ru"
    //Students data
    let names = ["Egor", "Vlad", "Oleg", "Stas", "Max", "Ibragim", "Abraham", "Daniil", "Ivan", "Julia", "Olga", "Irina", "Galina", "Igor", "Ruslan", "Artur", "Aslan", "Dasha", "Server", "George"]
    let surnames = ["Black", "Jhonson", "Ben", "Lyashok", "Ozhig", "Teamlead", "Van Helsing", "Shvedun", "Drigo", "Shvedun", "Timosh", "Gladun", "Shulga", "Gladun", "Mustaf", "Maxov", "Lion", "Slabko", "Linus", "Washington"]
    let rates = [1, 2, 3, 4, 5, 6, 7, 4, 6, 5, 7, 2, 7, 8, 9, 4, 0, 5, 7, 10]
    let genders = ["man","man","man","man","man","man","man","man","man","woman","woman","woman","woman","man","man","man","man","woman","man","man"]
    //Custom cell data
    let identifier = "MyCell"
    let nib = UINib(nibName: "CustomTableViewCell",bundle: nil)
    //filter by gender
    var filter: Bool = false
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FirstVC"
        createSearchBar()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(nib, forCellReuseIdentifier: self.identifier)
        
        for element in 0...19 {
            let newStudent = Student(name: self.names[element], surname: self.surnames[element], rate: self.rates[element], gender: self.genders[element])
            if element % 2 == 0{
                newStudent.addProfile(profile: "https://www.google.com")
            }
            self.students.append(newStudent)
        }
        print(self.students.count)
        self.students.sort {$0.surname < $1.surname}
        self.tableView.reloadData()
        self.filterButton.addTarget(self, action: #selector(filterByGender(params:)), for: .touchUpInside)
    }
    
    @objc func filterByGender(params: UIButton) {
        if filter == false {
            searchStudents = students.filter({$0.gender == "man"})
            self.searching = true
            self.filter = !self.filter
            self.tableView.reloadData()
        } else {
            self.searching = false
            self.filter = !self.filter
            self.tableView.reloadData()
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return self.searchStudents.count
        } else {
            return self.students.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! CustomTableViewCell
        if searching{
            cell.awakeFromNib(name: self.searchStudents[indexPath.row].name, surname: self.searchStudents[indexPath.row].surname, rate: self.searchStudents[indexPath.row].rate)
        } else {
            cell.awakeFromNib(name: self.students[indexPath.row].name, surname: self.students[indexPath.row].surname, rate: self.students[indexPath.row].rate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) has tapped")
        if let profile = self.students[indexPath.row].internetProfile{
            print("Yeah, profile of \(self.students[indexPath.row].surname) is \(profile)")
            let secondViewController = WebViewController(nibName: nil, bundle: nil)
            secondViewController.profile = self.students[indexPath.row].internetProfile
            self.navigationController?.pushViewController(secondViewController, animated: true)
        } else {
            let alert = UIAlertController(title: "No profile", message: "This student doesn't have any profile", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Got it"), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter text..."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchStudents = students.filter({$0.surname.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searching = true
        self.tableView.reloadData()
    }
    
    //Hide keybord when cancelButton tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("tap")
        if let searchBar = self.navigationItem.titleView {
            searchBar.endEditing(true)
        }
        
    }
}

