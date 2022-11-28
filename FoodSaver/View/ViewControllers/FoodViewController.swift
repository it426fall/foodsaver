//
//  FoodViewController.swift
//  FoodSaver
//
//  Created on 02/11/22.
//

import UIKit

class FoodViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var viewModel = FoodViewModel() {
        didSet {
            viewModel.food.bind { (food) in
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NSLocalizedString("Food", comment: "Food")
        navigationController?.navigationBar.sizeToFit()
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "Screen Title") as Any]
        
        if AppManager.manager.loginAccount?.account_type == Int16(AccountType.Receiver.rawValue) {
                     self.navigationItem.rightBarButtonItems?.remove(at: 0)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadAllAvialabelFood()
        tableView.reloadData()
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
}

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.food.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell") as? FoodTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.dataSource = self
        let food = viewModel.food.value[indexPath.row]
        cell.food = food
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = viewModel.food.value[indexPath.row]
        if let vc = storyboard?.instantiateViewController(identifier: "FoodDetailsViewController") as? FoodDetailsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.food = food
        }
    }
}

extension FoodViewController: FoodTableViewCellDelegate, FoodTableViewCellDataSource {
    func didSelectedFavorite(cell:FoodTableViewCell, favorite: Bool, food: Food) {
        viewModel.addToFavorites(add: favorite, food: food)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didLikeFood(cell:FoodTableViewCell, food: Food) {
        viewModel.addLike(food: food)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didUnlikeFood(cell:FoodTableViewCell, food: Food) {
        viewModel.addUnlike(food: food)
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func isFoodFavorite(food: Food) -> Bool {
        return viewModel.isFoodFavorite(food: food)
    }
}

