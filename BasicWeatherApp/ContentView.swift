

import SwiftUI

struct ContentView: View {
    @State private var city = ""
    @State private var temperature: String = "-"
    @State private var description: String = "-"
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter the name of the place", text: $city)
                            .padding()
                            .border(Color.gray)
            Text("Weather in \(city)")
                .font(.title)
            
            
            Text("Temperature: \(temperature)°C")
                .font(.headline)
            
            Text("Description: \(description)")
                .italic()
            
            Button("Refresh") {
                fetchWeather()
            }
        }
        .padding()
        .onAppear {
            fetchWeather()
        }
    }
    func fetchWeather() {
        let apiKey = "7c136fe1f401669d63eb2fe2033ff78e"
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "London"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            if let decoded = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.temperature = String(format: "%.1f", decoded.main.temp)
                    self.description = decoded.weather.first?.description ?? "No description"
                }
            }
        }.resume()
    }
    
}
#Preview {
    ContentView()
}
