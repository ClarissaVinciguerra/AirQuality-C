//
//  CitiesListViewController.swift
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 10/3/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var citiesTableView: UITableView!
    
    // MARK: - Properties
    var state: String?
    var country: String?
    var citiesArray: [String] = [] {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        fetchCities()
    }
    
    // MARK: - Methods and Helper Functions
    func updateViews() {
        DispatchQueue.main.async {
            self.citiesTableView.reloadData()
        }
    }
    
    func fetchCities() {
        guard let state = state, let country = country else { return }
        DVMCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities, _) in
            self.citiesArray = cities
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailView" {
            guard let indexPath = citiesTableView.indexPathForSelectedRow, let destination = segue.destination as? DetailViewController else { return }
            let cityToSend = citiesArray[indexPath.row]
            destination.city = cityToSend
            destination.state = state
            destination.country = country
        }
    }
}

// MARK: - Extensions
extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = citiesArray[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
}
