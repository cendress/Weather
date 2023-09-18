//
//  WeatherView.swift
//  Weather
//
//  Created by Christopher Endress on 9/18/23.
//

import SwiftUI

struct WeatherView: View {
  let weatherData: WeatherData?
  
  @Binding var addedWeather: [WeatherData]
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      VStack {
        Text(weatherData?.name ?? "Unknown")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom, 4)
        
        if let weatherDescription = weatherData?.weather.first?.description {
          Text(weatherDescription)
            .font(.title)
            .foregroundColor(.secondary)
            .padding(.bottom, 16)
        }
        
        HStack(spacing: 16) {
          Text("Temperature:")
            .font(.headline)
          Text("\(String(format: "%.0f°", weatherData?.main.temp ?? 0.0))")
            .font(.title)
            .fontWeight(.bold)
        }
        
        HStack(spacing: 16) {
          Text("High:")
            .font(.headline)
          Text("\(String(format: "%.0f°", weatherData?.main.temp_max ?? 0.0))")
            .font(.headline)
          
          Text("Low:")
            .font(.headline)
          Text("\(String(format: "%.0f°", weatherData?.main.temp_min ?? 0.0))")
            .font(.headline)
        }
      }
      .padding()
      .background(Color.white)
      .cornerRadius(16)
      .shadow(radius: 5)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Add") {
            if let weatherData = weatherData {
              addedWeather.append(weatherData)
            }
            presentationMode.wrappedValue.dismiss()
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }
}

struct WeatherView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherView(weatherData: WeatherData(name: "Boston", main: Main(temp: 72.5, temp_min: 60.0, temp_max: 80.0), weather: [Weather(id: 23, description: "Sunny")]), addedWeather: .constant([]))
  }
}
