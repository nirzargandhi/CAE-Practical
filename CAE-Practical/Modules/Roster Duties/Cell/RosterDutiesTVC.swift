//
//  RosterDutiesTVC.swift
//  CAE-Practical
//
//  Created by Nirzar Gandhi on 20/12/21.
//

class RosterDutiesTVC: UITableViewCell {
    
    //MARK: - UIImageView Outlet
    @IBOutlet weak var imgvType: UIImageView!
    
    //MARK: - UILabel Outlets
    @IBOutlet weak var lblFlight: UILabel!
    @IBOutlet weak var lblDutyType: UILabel!
    @IBOutlet weak var lblMatchCrew: UILabel!
    @IBOutlet weak var lblTiming: UILabel!
    
    //MARK: - Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Show Hide Labels Method
    func showHideLabels(isHide : Bool) {
        imgvType.image = nil
        
        imgvType.isHidden = isHide
        lblFlight.isHidden = isHide
        lblDutyType.isHidden = isHide
        lblMatchCrew.isHidden = isHide
        lblTiming.isHidden = isHide
    }
}
