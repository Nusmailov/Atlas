//
//  Section.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class Section: Codable {
    var id: Int
    var section_name: String
}


class SectionData: Codable {
    var sections: [Section]
}
