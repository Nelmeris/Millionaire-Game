//
//  GameSessionDelegate.swift
//  Millionaire
//
//  Created by Artem Kufaev on 16.12.2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

protocol GameSessionDelegate {
    var result: Observable<Float> { get }
    func scoreIncrease();
    func finish();
}
