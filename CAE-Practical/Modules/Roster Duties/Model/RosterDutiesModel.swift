//
//  RosterDutiesModel.swift
//  CAE-Practical
//
//  Created by Nirzar Gandhi on 20/12/21.
//

struct RosterDutiesModel : Codable {
    var flightnr : String?
    var date : String?
    var aircraft_type : String?
    var tail : String?
    var departure : String?
    var destination : String?
    var time_Depart : String?
    var time_Arrive : String?
    var dutyID : String?
    var dutyCode : String?
    var captain : String?
    var first_officer : String?
    var flight_attendant : String?
    
    enum CodingKeys: String, CodingKey {
        
        case flightnr = "Flightnr"
        case date = "Date"
        case aircraft_type = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case time_Depart = "Time_Depart"
        case time_Arrive = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case first_officer = "First Officer"
        case flight_attendant = "Flight Attendant"
    }
    
    /*
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flightnr = try values.decodeIfPresent(String.self, forKey: .flightnr)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        aircraft_type = try values.decodeIfPresent(String.self, forKey: .aircraft_type)
        tail = try values.decodeIfPresent(String.self, forKey: .tail)
        departure = try values.decodeIfPresent(String.self, forKey: .departure)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        time_Depart = try values.decodeIfPresent(String.self, forKey: .time_Depart)
        time_Arrive = try values.decodeIfPresent(String.self, forKey: .time_Arrive)
        dutyID = try values.decodeIfPresent(String.self, forKey: .dutyID)
        dutyCode = try values.decodeIfPresent(String.self, forKey: .dutyCode)
        captain = try values.decodeIfPresent(String.self, forKey: .captain)
        first_officer = try values.decodeIfPresent(String.self, forKey: .first_officer)
        flight_attendant = try values.decodeIfPresent(String.self, forKey: .flight_attendant)
    }
    */
}
