//
//  HolidayRequest.swift
//  Holiday
//
//  Created by 林大屍 on 2022/6/10.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
    
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "0660c67076ba60fc71500159812cca6afb9d36af"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidaysResponse.self, from: jsonData)
                let holidaydetail = holidaysResponse.response.holidays
                completion(.success(holidaydetail))
            } catch {
                //catch error
                completion(.failure(.canNotProcessData))
            }
            
        }
        //start
        dataTask.resume()
        
        
    }
    
    
}
