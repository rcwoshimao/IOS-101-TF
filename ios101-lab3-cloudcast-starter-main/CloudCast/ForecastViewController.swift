//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Rebecca Chen on 2023/9/26.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
            configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    @IBAction func didTapFowardButton(_ sender: UIButton) {
        selectedForecastIndex = min(forecasts.count-1, selectedForecastIndex + 1) // don't go lower than 0 index
            configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    private var forecasts = [WeatherForecast]()
    private var selectedForecastIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        forecasts = createMockData()
        configure(with: forecasts[selectedForecastIndex]) // configure the UI to show the first mock data
        // Do any additional setup after loading the view.
        
        
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                                UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func createMockData() -> [WeatherForecast]{
        // This is just using the Calendar API to get a few random dates
             let today = Date()
             var dateComponents = DateComponents()
             dateComponents.day = 1
             let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
             let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
             // Create a few mock data to show
             let mockData1 = WeatherForecast(windSpeed: 3.3,
                                             weatherCode: .violentRainShowers,
                                             precipitation: 33.3,
                                             temperature: 59.5,
                                             date:today)
             let mockData2 = WeatherForecast(windSpeed: 3.7,
                                             weatherCode: .fog,
                                             precipitation: 13.3,
                                             temperature: 65.5,
                                             date: tomorrow)
             let mockData3 = WeatherForecast(windSpeed: 2.8,
                                             weatherCode: .partlyCloudy,
                                             precipitation: 23.3,
                                             temperature: 49.5,
                                             date: dayAfterTomorrow)
             return [mockData1, mockData2, mockData3]
    }

    private func configure(with forecast: WeatherForecast) {
        forecastImageView.image = forecast.weatherCode.image
        descriptionLabel.text = forecast.weatherCode.description
        temperatureLabel.text = "\(forecast.temperature)°F"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: forecast.date)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
