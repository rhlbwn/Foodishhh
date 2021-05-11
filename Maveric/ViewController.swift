//
//  ViewController.swift
//  Maveric
//
//  Created by Rahul Bawane on 11/05/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var foodItems = [FoodItem]()
    var filterArray = [FoodItem]()
    var isFiltering = false
    
    //MARK:View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.register(SearchBarView.self, forHeaderFooterViewReuseIdentifier: "SearchBarView")
        tableView.register(UINib(nibName: "SearchBarView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchBarView")
        getFood()
    }
    
    //MARK: Custom functions
    func getFood() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "Foods", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                print(jsonData)
                do {
                    let items = try JSONDecoder().decode([FoodItem].self, from: jsonData)
                    self.foodItems = items
                    self.tableView.reloadData()
                } catch {
                    print("decode error")
                }
            }
        } catch {
            print(error)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : isFiltering ? self.filterArray.count : self.foodItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchBarView") as! SearchBarView
            view.delegate = self
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImagesCell", for: indexPath) as! ImagesCell
            return imageCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
            let foodItem = isFiltering ? self.filterArray[indexPath.row] : self.foodItems[indexPath.row]
            cell.itemImage.image = UIImage(named: foodItem.image)
            cell.itemLabel.text = foodItem.name
            return cell
        }
    }
}

extension ViewController: SearchProtocol {
    //MARK: Protocols
    func search(item: String) {
        filterArray.removeAll()
        if item.isEmpty {
            isFiltering = false
        } else {
            isFiltering = true
            for foodItem in foodItems {
                if foodItem.name.lowercased().contains(item.lowercased()) {
                    self.filterArray.append(foodItem)
                }
            }
        }
        self.tableView.reloadData()
    }
}
