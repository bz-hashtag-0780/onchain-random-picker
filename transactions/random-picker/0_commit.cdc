import "RandomPicker"

transaction(values: [UInt64]) {

    prepare(signer: auth(SaveValue) &Account) {

        let receipt: @RandomPicker.Receipt <- RandomPicker.commit(values: values)
        
        // Check that I don't already have a receipt stored
        if signer.storage.type(at: RandomPicker.ReceiptStoragePath) != nil {
            panic("Storage collision at path=".concat(RandomPicker.ReceiptStoragePath.toString()).concat(" a Receipt is already stored!"))
        }

        // Save that receipt to my storage
        // Note: production systems would consider handling path collisions
        signer.storage.save(<-receipt, to: RandomPicker.ReceiptStoragePath)
    }
}
