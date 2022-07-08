//
//  ContentView.swift
//  iExpense
//
//  Created by Derek Howes on 4/25/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var personalExpenses = [ExpenseItem]()
    @State private var businessExpenses = [ExpenseItem]()

    
    @State private var showingAddExpense = false
    
    @State private var currencyTypes = ["AFA","ALL","DZD","AOR","ARS","AMD","AWG","AUD","AZN","BSD","BHD","BDT","BBD","BYN","BZD","BMD","BTN","BOB","BWP","BRL","GBP","BND","BGN","BIF","KHR","CAD","CVE","KYD","XOF","XAF","XPF","CLP","CNY","COP","KMF","CDF","CRC","HRK","CUP","CZK","DKK","DJF","DOP","XCD","EGP","SVC","ERN","EEK","ETB","EUR","FKP","FJD","GMD","GEL","GHS","GIP","XAU","XFO","GTQ","GNF","GYD","HTG","HNL","HKD","HUF","ISK","XDR","INR","IDR","IRR","IQD","ILS","JMD","JPY","JOD","KZT","KES","KWD","KGS","LAK","LVL","LBP","LSL","LRD","LYD","LTL","MOP","MKD","MGA","MWK","MYR","MVR","MRO","MUR","MXN","MDL","MNT","MAD","MZN","MMK","NAD","NPR","ANG","NZD","NIO","NGN","KPW","NOK","OMR","PKR","XPD","PAB","PGK","PYG","PEN","PHP","XPT","PLN","QAR","RON","RUB","RWF","SHP","WST","STD","SAR","RSD","SCR","SLL","XAG","SGD","SBD","SOS","ZAR","KRW","LKR","SDG","SRD","SZL","SEK","CHF","SYP","TWD","TJS","TZS","THB","TOP","TTD","TND","TRY","TMT","AED","UGX","XFU","UAH","UYU","USD","UZS","VUV","VEF","VND","YER","ZMK","ZWL"]
    @State private var preferredCurreny = "USD"
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("Pick your preferred currency", selection: $preferredCurreny) {
                    ForEach(currencyTypes, id: \.self) {type in
                        Text(type)
                    }
                }
                
                List {
                    ForEach(personalExpenses) { item in
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                
                            }
                            Spacer()
                            
                            if item.amount < 10 {
                                Text(item.amount, format: .currency(code: preferredCurreny))
                                    .foregroundColor(.yellow)
                                
                            } else if item.amount < 100 {
                                Text(item.amount, format: .currency(code: preferredCurreny))
                                    .foregroundColor(.orange)
                                
                            } else {
                                Text(item.amount, format: .currency(code: preferredCurreny))
                                    .foregroundColor(.red)
                                
                            }
                        }
                        
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                List {
                    ForEach(businessExpenses) { item in
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                
                            }
                            Spacer()
                            
                            if item.amount < 10 {
                                Text(item.amount, format: .currency(code: preferredCurreny))
                                    .foregroundColor(.yellow)
                                
                            } else if item.amount < 100 {
                                Text(item.amount, format: .currency(code: preferredCurreny))
                                    .foregroundColor(.orange)
                                
                            } else {
                                Text(item.amount, format: .currency(code: preferredCurreny))
                                    .foregroundColor(.red)
                                
                            }
                        }
                        
                    }
                    .onDelete(perform: removeBusinessItems)
                }
                .onAppear(perform: seperateLists)
                .navigationTitle("iExpense")
                .toolbar {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
                .onChange(of: showingAddExpense) { _ in
                    seperateLists()
                }

            }
        }
    }
    func removePersonalItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        personalExpenses.remove(atOffsets: offsets)
    }
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        businessExpenses.remove(atOffsets: offsets)
    }
    
    func seperateLists() {
        for item in expenses.items {
            if item.type == "Personal" {
                personalExpenses.append(item)
            } else {
                businessExpenses.append(item)
            }
        }
        return
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
