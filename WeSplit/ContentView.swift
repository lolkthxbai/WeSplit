//
//  ContentView.swift
//  WeSplit
//
//  Created by Junior Garcia on 10/9/26.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool

	let localCurrency = Locale.current.currency?.identifier ?? "USD"

	var grandTotal: Double {
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection
		return checkAmount + tipValue
	}

	var totalPerPerson: Double {
		grandTotal / Double(numberOfPeople)
	}

	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField(
						"Amount",
						value: $checkAmount,
						format: .currency(code: localCurrency)
					)
					.keyboardType(.decimalPad)
					.focused($amountIsFocused)

					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(0..<100) {
							// Skips values 0 and 1 so the minimum is 2
							// and removes the need for magic numbers
							// to correctly calculate tip and total
							if $0 >= 2 {
								Text("\($0) people")
							}
						}
					}
				}

				Section("How much tip do you want to leave?") {
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(0..<101) {
							Text($0, format: .percent)
						}
					}
				}

				Section("Total amount") {
					Text(grandTotal, format: .currency(code: localCurrency))
				}

				Section("Amount per person") {
					Text(totalPerPerson, format: .currency(code: localCurrency))
				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
