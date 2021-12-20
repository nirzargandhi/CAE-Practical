//
//  DashboardVC.swift
//  CAE-Practical
//
//  Created by Nirzar Gandhi on 20/12/21.
//

import FontAwesome_swift
import UIKit

class RosterDutiesVC: UIViewController {
    
    //MARK: - UITableView Outlet
    @IBOutlet weak var tblRosterDuties: UITableView!
    
    //MARK: - UILabel Outlet
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - Variable Declaration
    var refreshControl = UIRefreshControl()
    var arrDateTblHeader = [String]()
    var arrRosterDuties : [RosterDutiesModel]?
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
        
        wsRosterDuties(isLoader: true)
    }
    
    //MARK: - Initialization Method
    func initialization() {
        
        showNavigationBar(isTabbar: false)
        
        setNavigationHeader(strTitleName: "Roster Duties", isTabbar: false)
        
        if #available(iOS 15.0, *) {
            tblRosterDuties.sectionHeaderTopPadding = 0.0
        }
        
        tblRosterDuties.rowHeight = UITableView.automaticDimension
        tblRosterDuties.estimatedRowHeight = UITableView.automaticDimension
        tblRosterDuties.tableFooterView = UIView()
        
        tblRosterDuties.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshDashboardData(_:)), for: .valueChanged)
    }
    
    //MARK: - Refresh Dashboard Data Method
    @objc private func refreshDashboardData(_ sender: Any) {
        wsRosterDuties(isLoader: false)
    }
    
    //MARK: - Webservice Call Method
    func wsRosterDuties(isLoader : Bool) {
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.msgNetworkConnection)
            return
        }
        
        ApiCall().get(apiUrl: WebServiceURL.rosterDutiesURL, model: [RosterDutiesModel].self, isLoader: isLoader, isAPIToken: true) { (success, responseData) in
            if success, let responseData = responseData as? [RosterDutiesModel] {
                self.arrRosterDuties = responseData
                
                if self.arrRosterDuties?.count ?? 0 > 0 {
                    
                    let strCurrentDate = Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_ddMMyyyy, isTimeZoneUTC: false).string(from: Date())
                    
                    self.arrDateTblHeader = [String]()
                    
                    for i in 0..<(self.arrRosterDuties?.count ?? 0) {
                        if !self.arrDateTblHeader.contains(where: {$0 == self.arrRosterDuties?[i].date ?? ""}) {
                            self.arrDateTblHeader.append(self.arrRosterDuties?[i].date ?? "")
                        }
                    }
                    
                    self.arrDateTblHeader.append(strCurrentDate)
                    
                    self.arrDateTblHeader = self.arrDateTblHeader.reversed()
                    
                    self.tblRosterDuties.reloadData()
                    
                    self.tblRosterDuties.isHidden = false
                    self.lblNoData.isHidden = true
                } else {
                    self.lblNoData.isHidden = false
                    self.tblRosterDuties.isHidden = true
                }
                
                self.refreshControl.endRefreshing()
            } else {
                mainThread {
                    self.view.makeToast(responseData != nil ? Utility().wsFailResponseMessage(responseData: responseData!) : AlertMessage.msgError)
                    
                    self.lblNoData.isHidden = false
                    self.tblRosterDuties.isHidden = true
                    
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource Extension
extension RosterDutiesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrDateTblHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrTempRosterDuties = arrRosterDuties?.filter({$0.date == arrDateTblHeader[section]})
        return arrTempRosterDuties?.count ?? 0 > 0 ? arrTempRosterDuties?.count ?? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let date = Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_ddMMyyyy, isTimeZoneUTC: false).date(from: arrDateTblHeader[section] ) {
            return "\(Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_ddMMMyyyy, isTimeZoneUTC: false).string(from: date))"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .appBlack()
        header.textLabel?.font = UIFont(name: "OpenSans-Bold", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0).withWeight(UIFont.Weight.bold)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrTempRosterDuties = arrRosterDuties?.filter({$0.date == arrDateTblHeader[indexPath.section]})
        
        if arrTempRosterDuties?.count ?? 0 > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kCellRosterDuties, for: indexPath) as! RosterDutiesTVC
            
            cell.showHideLabels(isHide: false)
            
            switch arrTempRosterDuties?[indexPath.row].dutyID ?? "" {
                
            case "POS":
                cell.imgvType.image = UIImage.fontAwesomeIcon(name: .plane, style: .solid, textColor: .appBlack(), size: CGSize(width: 30.0, height: 30.0))
                
                cell.lblFlight.text = "Positioning"
                
                cell.lblDutyType.text = arrTempRosterDuties?[indexPath.row].departure ?? ""
                
                cell.lblMatchCrew.isHidden = true
                
                cell.lblTiming.text = "\(arrTempRosterDuties?[indexPath.row].time_Depart ?? "") - \(arrTempRosterDuties?[indexPath.row].time_Arrive ?? "")"
                
            case "FLT":
                cell.imgvType.image = UIImage.fontAwesomeIcon(name: .planeDeparture, style: .solid, textColor: .appBlack(), size: CGSize(width: 30.0, height: 30.0))
                
                cell.lblFlight.text = "\(arrTempRosterDuties?[indexPath.row].departure ?? "") - \(arrTempRosterDuties?[indexPath.row].destination ?? "")"
                
                cell.lblDutyType.isHidden = true
                
                cell.lblMatchCrew.isHidden = true
                
                cell.lblTiming.text = "\(arrTempRosterDuties?[indexPath.row].time_Depart ?? "") - \(arrTempRosterDuties?[indexPath.row].time_Arrive ?? "")"
                
            case "OFD":
                cell.imgvType.image = UIImage.fontAwesomeIcon(name: .suitcase, style: .solid, textColor: .appBlack(), size: CGSize(width: 30.0, height: 30.0))
                
                cell.lblFlight.text = "Layover"
                
                cell.lblDutyType.text = arrTempRosterDuties?[indexPath.row].departure ?? ""
                
                cell.lblMatchCrew.isHidden = true
                
                cell.lblTiming.text = "\(arrTempRosterDuties?[indexPath.row].time_Depart ?? "") - \(arrTempRosterDuties?[indexPath.row].time_Arrive ?? "")"
                
            case "SBY":
                cell.imgvType.image = UIImage.fontAwesomeIcon(name: .clipboard, style: .solid, textColor: .appBlack(), size: CGSize(width: 30.0, height: 30.0))
                
                cell.lblFlight.text = "Standby"
                
                cell.lblDutyType.text = "SBY (\(arrTempRosterDuties?[indexPath.row].departure ?? ""))"
                
                cell.lblMatchCrew.text = "Match Crew"
                
                cell.lblTiming.text = "\(arrTempRosterDuties?[indexPath.row].time_Depart ?? "") - \(arrTempRosterDuties?[indexPath.row].time_Arrive ?? "")"
                
            case "DO":
                cell.imgvType.image = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .appBlack(), size: CGSize(width: 30.0, height: 30.0))
                
                cell.lblFlight.text = "Off"
                
                cell.lblDutyType.text = arrTempRosterDuties?[indexPath.row].departure ?? ""
                
                cell.lblMatchCrew.isHidden = true
                
                cell.lblTiming.isHidden = true
                
            default:
                cell.showHideLabels(isHide: true)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kCellNoRosterDuties, for: indexPath) as! RosterDutiesTVC
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let arrTempRosterDuties = arrRosterDuties?.filter({$0.date == arrDateTblHeader[indexPath.section]})
        
        if arrTempRosterDuties?.count ?? 0 > 0 {
            let objRosterDutiesDetailVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kRosterDutyDetailVC) as! RosterDutyDetailVC
            objRosterDutiesDetailVC.dictRosterDuties = arrTempRosterDuties?[indexPath.row]
            self.navigationController?.pushViewController(objRosterDutiesDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
