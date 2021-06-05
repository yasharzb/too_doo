//
//  CommandController.swift
//  too_doo
//
//  Created by YashyZB on 6/5/21.
//  Copyright © 2021 SUT. All rights reserved.
//

import Foundation

func handle_help(inpArray: [String]) {
    if inpArray.count > ParamOrder.PARAM_1.rawValue {
        let cmdHelp = inpArray[ParamOrder.PARAM_1.rawValue].uppercased()
        print(help(command: Command(rawValue: cmdHelp)))
    } else {
        print(help(command: nil))
    }
}
