//
//  StopperModel.swift
//  ClockWork
//
//  Created by eyal avisar on 13/10/2020.
//

import Foundation

var stopperTimes:[(Int, Int, Double)] = []

var timer: Timer?
var milliseconds = 0.0
var seconds = 0
var minutes = 0
var hours = 0

var clockState:ClockState = .Timer
var timerStartTime = ""
