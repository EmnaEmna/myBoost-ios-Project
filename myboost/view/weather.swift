//
//  weather.swift
//  myboost
//
//  Created by Mac2021 on 13/4/2023.
//
import SwiftUI
import Alamofire

struct WeatherView: View {
    @State private var currentWeather: String = ""
    @State private var currentDate = Date()

    var body: some View {
            HStack{
                VStack(alignment: .leading){
                    Text("Today's ")
                        .font(.title)
                        
                        
                    Text("\(currentDate, formatter: dateFormatter)")
                        .padding(.trailing)
                        
                }.padding(.horizontal).colorInvert()
                Text(currentWeather)
                    .font(.title2)
                    .padding()
                    .colorInvert()
                
            }.background(
                Image("vue-panoramique-riviere-neva-aube")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10.0)
            )
        
        .onAppear {
            fetchWeatherData()
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    private func fetchWeatherData() {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=Tunis&appid=e5fc5c1b76046950e02ee63087de83bc&units=metric"

        AF.request(url).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                currentWeather = "\(weatherResponse.main.temp)°C and \(weatherResponse.weather.first?.description ?? "Unknown")"
            case .failure(let error):
                print(error.localizedDescription)
                currentWeather = "Error fetching weather data"
            }
        }
    }
}

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
