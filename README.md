## Yelp

This is a Yelp search app using the [Yelp API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: `<Number of hours spent>`

### Features

#### Required

- [YES] Search results page
   - [YES] Table rows should be dynamic height according to the content height
   - [YES] Custom cells should have the proper Auto Layout constraints
   - [YES] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [YES] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [YES] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
   - [YES] The filters table should be organized into sections as in the mock.
   - [YES] You can use the default UISwitch for on/off states. Optional: implement a custom switch
   - [YES] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [YES] Display some of the available Yelp categories (choose any 3-4 that you want).

#### Optional

- [ ] Search results page
   - [YES] Infinite scroll for restaurant results
   - [YES] Implement map view of restaurant results
   - [YES] Search bar expands
- [ ] Filter page
   - [YES] Radius filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)
- [ ] Implement the restaurant detail page.

### Walkthrough

![Video Walkthrough](foodie/YelpDemo.gif)

