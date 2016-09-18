# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
  -   In the normal usage flow, a CLI greets the user and asks the user to enter a ticker symbol.  The CLI then displays a quote for the corresponding stock or ETF and then presents the user with a list menu to either display a company description, return to the ticker symbol prompt, or exit the gem.  If the user chooses to display a company description, the gem will present the user with a list menu to redisplay the quote, return to the ticker symbol prompt, or exit the gem.  This normal flow can be broken by entering DEV at the ticker symbol prompt to enter development mode where the user can load a fixture for debugging purposes.
- [x] Pull data from an external source
  -   The gem scrapes stock information from Google Finance.
- [x] Implement both list and detail views
  -   The CLI presents the user with several list views.  In the regular flow, the user is presented with lists to toggle between a quote, a company description, and a ticker symbol prompt.  The detail views are the quote and company description displays.
