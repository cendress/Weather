//
//  ContentView.swift
//  Weather
//
//  Created by Christopher Endress on 9/18/23.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var weatherViewModel: WeatherViewModel
  
  @State private var searchText = ""
  @State private var isShowingWeatherView = false
  @State private var addedWeather: [WeatherData] = []
  
  var body: some View {
    NavigationView {
      VStack {
        HStack(spacing: 8) {
          Image(systemName: "magnifyingglass")
          TextField("Search for a city", text: $searchText)
          Button("Cancel") {
            searchText = ""
          }
        }
        .padding()
        .onSubmit {
          weatherViewModel.fetchWeatherData(cityName: searchText)
          
          searchText = ""
          
          isShowingWeatherView = true
        }
        
        Spacer()
        
        ScrollViewReader { proxy in
          ScrollView {
            ForEach(addedWeather.indices, id: \.self) { index in
              let weatherData = addedWeather[index]
              HStack {
                VStack(alignment: .leading) {
                  Text(weatherData.name)
                    .font(.headline)
                    .padding()
                  Text("\(weatherData.weather.first?.description ?? "Not available")")
                    .font(.subheadline)
                    .padding()
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .trailing) {
                  Text("\(String(format: "%.0f°", weatherData.main.temp))")
                    .font(.title)
                    .padding()
                  HStack {
                    Text("H: \(String(format: "%.0f°", weatherData.main.temp_max))")
                      .font(.subheadline)
                      .padding()
                    
                    Text("L: \(String(format: "%.0f°", weatherData.main.temp_min))")
                      .font(.subheadline)
                      .padding()
                  }
                }
                .frame(maxWidth: .infinity)
              }
              .background(.thinMaterial)
              .cornerRadius(20)
              .shadow(radius: 5)
              .padding()
              .id(index)
            }
          }
        }
        
        Spacer()
      }
      .navigationTitle("Weather")
      .sheet(isPresented: $isShowingWeatherView) {
        WeatherView(weatherData: weatherViewModel.weatherData, addedWeather: $addedWeather)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(weatherViewModel: WeatherViewModel())
  }
}
