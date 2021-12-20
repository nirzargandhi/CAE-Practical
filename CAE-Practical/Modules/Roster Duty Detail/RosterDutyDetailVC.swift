//
//  RosterDutiesDetailVC.swift
//  CAE-Practical
//
//  Created by Nirzar Gandhi on 20/12/21.
//

class RosterDutyDetailVC: UIViewController {
    
    //MARK: - UILabel Outlets
    @IBOutlet weak var lblFlightNR: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAircraftType: UILabel!
    @IBOutlet weak var lblTail: UILabel!
    @IBOutlet weak var lblDeparture: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblTimeDepart: UILabel!
    @IBOutlet weak var lblTimeArrive: UILabel!
    @IBOutlet weak var lblDutyID: UILabel!
    @IBOutlet weak var lblDutyCode: UILabel!
    @IBOutlet weak var lblCaptain: UILabel!
    @IBOutlet weak var lblFirstOfficer: UILabel!
    @IBOutlet weak var lblFlightAttendant: UILabel!
    
    //MARK: - Variable Declaration
    var dictRosterDuties : RosterDutiesModel?
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
        
        setData()
    }
    
    //MARK: - Initialization Method
    func initialization() {
        setNavigationHeader(strTitleName: "Roster Duty Details", isTabbar: false)
        setupBackButton(isTabbar: false)
    }
    
    //MARK: - Set Data Method
    func setData() {
        
        lblFlightNR.text = dictRosterDuties?.flightnr ?? ""
        
        if let date = Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_ddMMyyyy, isTimeZoneUTC: false).date(from: dictRosterDuties?.date ?? "01/01/1947") {
            lblDate.text = "\(Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_ddMMMyyyy, isTimeZoneUTC: false).string(from: date))"
        } else {
            lblDate.text = ""
        }
        
        lblAircraftType.text = dictRosterDuties?.aircraft_type ?? ""
        
        lblTail.text = dictRosterDuties?.tail ?? ""
        
        lblDeparture.text = dictRosterDuties?.departure ?? ""
        
        lblDestination.text = dictRosterDuties?.destination ?? ""
        
        lblTimeDepart.text = dictRosterDuties?.time_Depart ?? ""
        
        lblTimeArrive.text = dictRosterDuties?.time_Arrive ?? ""
        
        lblDutyID.text = dictRosterDuties?.dutyID ?? ""
        
        lblDutyCode.text = dictRosterDuties?.dutyCode ?? ""
        
        lblCaptain.text = dictRosterDuties?.captain ?? ""
        
        lblFirstOfficer.text = dictRosterDuties?.first_officer ?? ""
        
        lblFlightAttendant.text = dictRosterDuties?.flight_attendant ?? ""
    }
}
