# Stocks

This ruby gem allows the user to enter a ticker symbol and retrieve a quote and company description scraped from financial websites.

## Installation

This gem can be installed by running `gem install stocks`.  Alternatively, you may clone the `stocks-cli-gem` repository at https://github.com/lair001/stocks-cli-gem into a directory or folder.

## Usage

If you installed stocks via `gem install stocks`, you can simply run `stocks` from any folder. If you copied the `stocks-cli-gem` repository into a folder, you must navigate to that folder and run `bin/stocks`.

The gem will greet you and prompt you for a ticker symbol.  Once you have entered a valid ticker symbol, the gem will show you a quote for the corresponding stock.  Press enter and the gem will present you with a list menu to either display a company description, enter another ticker symbol or exit the program.

This typical flow can be interrupted by entering `DEV` at the ticker symbol prompt.  This will take you into development mode where you can load fixtures for debugging purposes.  If you need further debugging and development resources, the `stocks-cli-gem` repository includes a full set of `Rspec` tests and a `rake console`.

## Contributing 

If you want to contribute, feel free to fork the `stock-cli-gem` repository and submit a pull request.  You may also email Samuel Lair at lair002@gmail.com.

## License

This gem is open source under the MIT license.  See https://github.com/lair001/stocks-cli-gem/blob/master/LICENSE.
