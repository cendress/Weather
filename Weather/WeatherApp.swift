//
//  WeatherApp.swift
//  Weather
//
//  Created by Christopher Endress on 9/18/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: WeatherViewModel())
        }
    }
}
