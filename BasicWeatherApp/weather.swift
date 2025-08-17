//
//  weather.swift
//  productname2
//
//  Created by lalita juyal on 2025/08/17.
//


import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
