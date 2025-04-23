import "RandomPicker"

transaction {

    prepare(signer: auth(BorrowValue, LoadValue) &Account) {
        // Load my receipt from storage
        let receipt <- signer.storage.load<@RandomPicker.Receipt>(from: RandomPicker.ReceiptStoragePath)
            ?? panic("No Receipt found in storage at path=".concat(RandomPicker.ReceiptStoragePath.toString()))

        // Reveal by redeeming my receipt
        let winningResult: UInt64 = RandomPicker.reveal(receipt: <-receipt)
    }

}
