//
//  TFAGetListRequest.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/18/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation
import SwiftyJSON

class TFAGetListRequest: TFARequestProtocol {
    
    let requestURL: String = (TFASettingsHelper.getBaseUrl() + "/topfreeapplications/limit=20/json")
    
    var parameters: Dictionary< String, String> = [String: String]()
    
    var headers: Dictionary< String, String> = [String: String]()
    
    func request(success:@escaping (_ response:Any) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        self.makeRequest(url: self.requestURL, parameters:self.parameters, headers: self.headers, success: { (data) in
            
            let resutls = JSON(data)
            
            let list = resutls["feed"]["entry"].arrayValue
            let array = self.parseRequest(data: list)
            
            success(array)
            
        }) { (error) in
            failure(error)
            
        }
    }
    
    func parseRequest(data:Any) -> Any {
        
        let appsList = TFARealmHelper.shared.persistAppsListData(data: data as! NSArray)
        
        return appsList
    }
    
}
