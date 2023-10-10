//
//  ContentView.swift
//  WeSplit
//
//  Created by Enzo Borges on 27/09/2023.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountInputIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    let currencyCode = Locale.current.currencyCode ?? "USD"
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipValue = checkAmount * Double(tipPercentage) / 100
        let total = checkAmount + tipValue
        
        return total / peopleCount
    }
    var checkTotal : Double{
        totalPerPerson * Double(numberOfPeople + 2)
    }
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
                    .focused($amountInputIsFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2 ..< 100){
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101){
                            Text("\($0)%")
                        }
                    }
                } header : {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(checkTotal, format:
                            .currency(code: currencyCode))
                    .foregroundColor(tipPercentage != 0 ? .black : .red)
                } header:{
                    Text("Check Total")
                    .foregroundColor(tipPercentage != 0 ? .black : .red)
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                } header : {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountInputIsFocused = false
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
}
