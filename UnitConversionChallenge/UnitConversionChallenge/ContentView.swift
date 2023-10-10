//
//  ContentView.swift
//  UnitConversionChallenge
//
//  Created by Enzo Borges on 29/09/2023.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var isInputFocused: Bool
    @State private var input = 0.0
    @State private var conversionType = "Temperature"
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    let conversionTypes = ["Temperature","Length","Time","Volume"]
    let conversionUnits = [
        "Temperature" : ["Celsius","Fahrenheit","Kelvin"],
        "Length" : ["Meters","Kilometers","Feets","Yards","Miles"],
        "Time" : ["Seconds","Minutes","Hours","Days"],
        "Volume" : ["Milliliters","Liters","Cups","Pints","Gallons"],
    ]
    var currentUnits: Array<String> {
        conversionUnits[conversionType] ?? []
    }
    var output : Double {
        switch conversionType{
        case "Temperature":
            return convertTemperature()
        case "Length":
            return convertLength()
        case "Time":
            return convertTime()
        case "Volume":
            return convertVolume()
        default:
            return 0
        }
    }
    
    func convertTemperature() -> Double{
        //Base Value on Kelvin
        var baseValue:Double{
            if(inputUnit == "Celsius") {return input + 273.15}
            else if(inputUnit == "Fahrenheit") {
                return (input - 32) * 5 / 9 + 273.15
                
            }
            else {return input}
        }
        switch outputUnit{
        case "Celsius":
            return baseValue - 273.15
        case "Fahrenheit":
            return (baseValue - 273.15) * 1.8 + 32;
        default:
            return baseValue
        }
    }
    func convertLength() -> Double{
        //Base Value on Meters
        var baseValue:Double{
            if(inputUnit == "Kilometers") {return input * 1000}
            else if(inputUnit == "Feets") {return input * 0.3048}
            else if(inputUnit == "Yards") {return input * 0.9144}
            else if(inputUnit == "Miles") {return input * 1609.344}
            else {return input}
        }
        switch outputUnit{
        case "Kilometers":
            return baseValue / 1000
        case "Feets":
            return baseValue / 0.3048
        case "Yards":
            return baseValue / 0.9144
        case "Miles":
            return baseValue / 1609.344
        default:
            return baseValue
        }
    }
    func convertTime() -> Double{
        //Base Value on Seconds
        var baseValue:Double{
            if(inputUnit == "Days") {return input * 86400}
            else if(inputUnit == "Hours") {return input * 3600}
            else if(inputUnit == "Minutes") {return input * 60}
            else {return input}
        }
        switch outputUnit{
        case "Days":
            return baseValue / 86400
        case "Hours":
            return baseValue / 3600
        case "Minutes":
            return baseValue / 60
        default:
            return baseValue
        }
    }
    func convertVolume() -> Double{
        //Base Value on Milliliters
        var baseValue:Double{
            if(inputUnit == "Gallons") {return input * 3785.411784}
            else if(inputUnit == "Pints") {return input * 473.176473}
            else if(inputUnit == "Cups") {return input * 236.5882365}
            else if(inputUnit == "Liters") {return input * 1000}
            else {return input}
        }
        switch outputUnit{
        case "Gallons":
            return baseValue / 3785.411784
        case "Pints":
            return baseValue / 473.176473
        case "Cups":
            return baseValue / 236.5882365
        case "Liters":
            return baseValue / 1000
        default:
            return baseValue
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Type",selection: $conversionType){
                        ForEach(conversionTypes, id: \.self){
                            Text("\($0)")
                        }
                    }.onChange(of: conversionType, perform: { _ in
                        inputUnit = currentUnits[0]
                        outputUnit = currentUnits[1]
                    })
                } header: {
                    Text("Select a conversion type")
                }
                Section{
                    TextField("User Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                    Picker("Input unit", selection: $inputUnit){
                        ForEach(currentUnits, id: \.self){
                            Text("\($0)")
                        }
                    } .pickerStyle(.segmented)
                } header :{
                    Text("From")
                }
                Section{
                    Text("\(output.formatted())")
                    Picker("Input unit", selection: $outputUnit){
                        ForEach(currentUnits, id: \.self){
                            Text("\($0)")
                        }
                    } .pickerStyle(.segmented)
                }
                header :{
                    Text("To")
                }
            }
            .navigationTitle("Universal Conversor")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
