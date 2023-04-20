//
//  BeerIngredientsTableViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/20/23.
//

import UIKit

class BeerIngredientsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BeerIngredientsViewModel(delegate: self)
    }
    
    // MARK: - Properties
    var beer: Beer?
    var viewModel: BeerIngredientsViewModel!
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Malt"
        case 1: return "Hops"
        case 2: return "Yeast"
        case 3: return "Method"
        case 4: return "Brewers Tips"
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = beer?.ingredients else { return 0 }
        
        switch section {
        case 0: return ingredients.malt.count
        case 1: return ingredients.hops.count
        case 2: return ingredients.yeast == nil ? 0 : 1
        case 3: return 1
        case 4: return 1
        default: return 0
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        guard let ingredients = beer?.ingredients,
              let brewDetail = beer?.boilVolume,
              let method = beer?.method else { return cell }
        
        var config = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            let malt = ingredients.malt[indexPath.row]
            config.text = "\(malt.name), \(malt.amount.value) \(malt.amount.unit)"
        case 1:
            let hop = ingredients.hops[indexPath.row]
            config.text = "\(hop.name), \(hop.amount.value) \(hop.amount.unit)"
            config.secondaryText = "When: \(hop.add), Attribute: \(hop.attribute)"
        case 2:
            if let yeast = ingredients.yeast {
                config.text = yeast
            }
            
//        case 3:
//            let boilVolume = brewDetail
//            let mash = method.mashTemp
//            let fermentation = method.fermentation
//            let twist = method.twist
//            var temp = 65.0
//            var duration = 0.0
//            
//            for v in mash {
//                guard let v.temp?.value = v.temp?.value,
//                      let v.duration = v.duration else { return }
//                    temp = v.temp?.value
//                    duration = v.duration
//                
//            }
//            config.text = "Boil Volume: \(boilVolume.value) \(boilVolume.unit). Mash Temp: \(temp) Celsius for \(mash).  Fermentation: \(temp) Duration: \(duration)"
//            
        case 4:
            if let brewerTip = beer?.brewersTips {
                config.text = brewerTip
            }
        default:
            break
        }
        
        cell.contentConfiguration = config
        return cell
    }
}

extension BeerIngredientsTableViewController: BeerIngredientsViewModelDelegate {
    func beerLoadedSuccessfully(with beer: Beer) {
        DispatchQueue.main.async {
            self.beer = beer
            self.tableView.reloadData()
        }
    }
}
