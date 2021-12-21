//
//  OfflineRosterDutiesDBManager.swift
//  CAE-Practical
//
//  Created by Nirzar Gandhi on 21/12/21.
//

let sharedInstance = OfflineRosterDutiesDBManager()

class OfflineRosterDutiesDBManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> OfflineRosterDutiesDBManager {
        if(sharedInstance.database == nil) {
            print("Database Path : \(Utility().getPath(fileName: "RosterDuties.sqlite"))")
            sharedInstance.database = FMDatabase(path: Utility().getPath(fileName: "RosterDuties.sqlite"))
        }
        return sharedInstance
    }
    
    func addRosterDutiesData(objOfflineRosterDuties: OfflineRosterDutiesModel) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO tblRosterDuties (id, flightnr, date, aircraft_type, tail, departure, destination, time_Depart, time_Arrive, dutyID, dutyCode, captain, first_officer, flight_attendant) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [objOfflineRosterDuties.id as Any, objOfflineRosterDuties.flightnr as Any, objOfflineRosterDuties.date as Any, objOfflineRosterDuties.aircraft_type as Any, objOfflineRosterDuties.tail as Any, objOfflineRosterDuties.departure as Any, objOfflineRosterDuties.destination as Any, objOfflineRosterDuties.time_Depart as Any, objOfflineRosterDuties.time_Arrive as Any, objOfflineRosterDuties.dutyID as Any, objOfflineRosterDuties.dutyCode as Any, objOfflineRosterDuties.captain as Any, objOfflineRosterDuties.first_officer as Any, objOfflineRosterDuties.flight_attendant as Any])
        
        if !isInserted {
            print(sharedInstance.database?.lastErrorMessage() as Any)
        }
        
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateRosterDutiesData(objOfflineRosterDuties: OfflineRosterDutiesModel) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE tblRosterDuties SET flightnr=?, date=?, aircraft_type=?, tail=?, departure=?, destination=?, time_Depart=?, time_Arrive=?, dutyID=?, dutyCode=?, captain=?, first_officer=?, flight_attendant=?, WHERE id=?", withArgumentsIn: [objOfflineRosterDuties.id as Any, objOfflineRosterDuties.flightnr as Any, objOfflineRosterDuties.date as Any, objOfflineRosterDuties.aircraft_type as Any, objOfflineRosterDuties.tail as Any, objOfflineRosterDuties.departure as Any, objOfflineRosterDuties.destination as Any, objOfflineRosterDuties.time_Depart as Any, objOfflineRosterDuties.time_Arrive as Any, objOfflineRosterDuties.dutyID as Any, objOfflineRosterDuties.dutyCode as Any, objOfflineRosterDuties.captain as Any, objOfflineRosterDuties.first_officer as Any, objOfflineRosterDuties.flight_attendant as Any])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteRosterDutiesData(objOfflineRosterDuties: OfflineRosterDutiesModel) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM tblRosterDuties WHERE id=?", withArgumentsIn: [objOfflineRosterDuties.id as Any])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func deleteAllRosterDutiesData() -> Bool {
        sharedInstance.database!.open()
        let isAllDataDeleted = sharedInstance.database!.executeStatements("DELETE FROM tblRosterDuties")
        //executeUpdate("DELETE FROM tblRosterDuties", withArgumentsIn: [])
        sharedInstance.database!.close()
        return isAllDataDeleted
    }
    
    func getAllRosterDutiesData() -> [OfflineRosterDutiesModel] {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblRosterDuties", withArgumentsIn: [])
        var arrOfflineRosterDutiesModel : [OfflineRosterDutiesModel] = [OfflineRosterDutiesModel]()
        if (resultSet != nil) {
            while resultSet.next() {
                let objOfflineRosterDuties : OfflineRosterDutiesModel = OfflineRosterDutiesModel()
                
                if resultSet.string(forColumn: "id") != nil {
                    objOfflineRosterDuties.id = Int(resultSet.int(forColumn: "id"))
                }
                
                if resultSet.string(forColumn: "flightnr") != nil {
                    objOfflineRosterDuties.flightnr = resultSet.string(forColumn: "flightnr")!
                }
                
                if resultSet.string(forColumn: "date") != nil {
                    objOfflineRosterDuties.date = resultSet.string(forColumn: "date")!
                }
                
                if resultSet.string(forColumn: "aircraft_type") != nil {
                    objOfflineRosterDuties.aircraft_type = resultSet.string(forColumn: "aircraft_type")!
                }
                
                if resultSet.string(forColumn: "tail") != nil {
                    objOfflineRosterDuties.tail = resultSet.string(forColumn: "tail")!
                }
                
                if resultSet.string(forColumn: "departure") != nil {
                    objOfflineRosterDuties.departure = resultSet.string(forColumn: "departure")!
                }
                
                if resultSet.string(forColumn: "destination") != nil {
                    objOfflineRosterDuties.destination = resultSet.string(forColumn: "destination")!
                }
                
                if resultSet.string(forColumn: "time_Depart") != nil {
                    objOfflineRosterDuties.time_Depart = resultSet.string(forColumn: "time_Depart")!
                }
                
                if resultSet.string(forColumn: "time_Arrive") != nil {
                    objOfflineRosterDuties.time_Arrive = resultSet.string(forColumn: "time_Arrive")!
                }
                
                if resultSet.string(forColumn: "dutyID") != nil {
                    objOfflineRosterDuties.dutyID = resultSet.string(forColumn: "dutyID")!
                }
                
                if resultSet.string(forColumn: "dutyCode") != nil {
                    objOfflineRosterDuties.dutyCode = resultSet.string(forColumn: "dutyCode")!
                }
                
                if resultSet.string(forColumn: "captain") != nil {
                    objOfflineRosterDuties.captain = resultSet.string(forColumn: "captain")!
                }
                
                if resultSet.string(forColumn: "first_officer") != nil {
                    objOfflineRosterDuties.first_officer = resultSet.string(forColumn: "first_officer")!
                }
                
                if resultSet.string(forColumn: "flight_attendant") != nil {
                    objOfflineRosterDuties.flight_attendant = resultSet.string(forColumn: "flight_attendant")!
                }
                
                arrOfflineRosterDutiesModel.append(objOfflineRosterDuties)
            }
        }
        
        sharedInstance.database!.close()
        
        return arrOfflineRosterDutiesModel
    }
}


