//
//  StatesListViewController.swift
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 10/3/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var statesTableView: UITableView!
    
    // MARK: - Properties
    var country: String?
    var statesArray: [String] = [] {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        statesTableView.delegate = self
        statesTableView.dataSource = self
        fetchStatesArray()
    }
    
    // MARK: - Methods and Helper Functions
    func updateViews() {
        DispatchQueue.main.async {
            self.statesTableView.reloadData()
        }
    }
    
    func fetchStatesArray() {
        guard let country = country else { return }
        DVMCityAirQualityController.fetchSupportedStates(inCountry: country) { (states, _) in
            self.statesArray = states
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityVC" {
            guard let indexPath = statesTableView.indexPathForSelectedRow, let destination = segue.destination as? CitiesListViewController else { return }
            let stateToSend = statesArray[indexPath.row]
            destination.country = country
            destination.state = stateToSend
        }
    }
}

// MARK: - Extension
extension StatesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        let state = statesArray[indexPath.row]
        cell.textLabel?.text = state
        
        return cell
    }
}
