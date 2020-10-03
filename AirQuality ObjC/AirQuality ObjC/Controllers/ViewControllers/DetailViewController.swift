//
//  DetailViewController.swift
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 10/3/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cityStateCountryNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var airQualityIndexLabel: UILabel!
    
    // MARK: - Properties
    var country: String?
    var state: String?
    var city: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Methods and Helper Functions
    func updateViews() {
        guard let country = country, let state = state, let city = city else { return }
        DVMCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityObject, _) in
            DispatchQueue.main.async {
                self.cityStateCountryNameLabel.text = "\(cityObject.city), \(cityObject.state) \n \(cityObject.country)"
                self.humidityLabel.text = "Humidity: \(cityObject.weather.humidity)%"
                self.temperatureLabel.text = "Temperature: \(cityObject.weather.temperature)℃"
                self.windSpeedLabel.text = "Wind Speed: \(cityObject.weather.windSpeed) m/s"
                self.airQualityIndexLabel.text = "Air Quality: \(cityObject.pollution.airQualityIndex)"
            }
        }
    }
}
