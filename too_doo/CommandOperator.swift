//
//  CommandController.swift
//  too_doo
//
//  Created by YashyZB on 6/5/21.
//  Copyright © 2021 SUT. All rights reserved.
//

import Foundation

let NONE: String = ""
func help(command: Command?) -> String {
    var helpInstr: String = NONE
    for cmd in Command.allCases{
        if command != nil && command != cmd{
            continue
        }
        helpInstr += cmd.help
        helpInstr += "\n"
    }
    return helpInstr
}
