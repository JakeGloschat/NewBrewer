//
//  BeerIngredientsView.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import UIKit

class BeerIngredientsViewController: UITableViewController {

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = BeerIngredientsViewModel(delegate: self)
	}

	// MARK: - Properties
	var beer: Beer?
	var viewModel: BeerIngredientsViewModel!

	// MARK: - TableViewDataSource
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 4
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0: return "Malt"
		case 1: return "Hops"
		case 2: return "Yeast"
		case 3: return "Brewers Tips"
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
		default: return 0
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
		guard let ingredients = beer?.ingredients else { return cell }

		var content = cell.defaultContentConfiguration()

		switch indexPath.section {
		case 0:
			let malt = ingredients.malt[indexPath.row]
			content.text = "\(malt.name), \(malt.amount.value) \(malt.amount.unit)"
		case 1:
			let hop = ingredients.hops[indexPath.row]
			content.text = "\(hop.name), \(hop.amount.value) \(hop.amount.unit)"
			content.secondaryText = "When: \(hop.add), Butt: \(hop.attribute))"
		case 2:
			if let yeast = ingredients.yeast {
				content.text = yeast
			}
		case 3:
			if let brewerTip = beer?.brewersTips {
				content.text = brewerTip
			}
		default:
			break
		}

		cell.contentConfiguration = content
		return cell
	}
}

// MARK: - Extensions
extension BeerIngredientsViewController: BeerIngredientsViewModelDelegate {
	func beerLoadedSuccessfully(with beer: Beer) {
		DispatchQueue.main.async {
			self.beer = beer
			self.tableView.reloadData()
		}
	}
}
