//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Christopher Endress on 9/18/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
  @Published var weatherData: WeatherData?
  
  func fetchWeatherData(cityName: String) {
    let apiKey = Keys.weatherApiKey
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=imperial")!
    
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let data = data, error == nil else {
        print("\(error?.localizedDescription ?? "Unknown error")")
        return
      }
      
      do {
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
        DispatchQueue.main.async {
          self?.weatherData = decodedData
        }
      } catch {
        print("Error decoding data, \(error.localizedDescription)")
      }
    }
    .resume()
  }
}

