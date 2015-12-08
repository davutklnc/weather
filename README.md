# weather
This application works with http://openweathermap.org provided API

Weather app uses users current location to get newest weather data if location permissions are given that time.

User can also change Selected city by typing at the search text field. Autocomplate dropdown menu will appear to choose closest selection.

To add auto complete feature with client side database I trimmed the data source from 300k cities to around 10k cities. Searching from cities are not working on main thread. So it will not block user interface.

Server calls and URL calls are not on main thread. Calls return values and display them on main thread.

