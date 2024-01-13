## Instructions

1. Create a branch off of your Sweater Weather project called `final`.
1. As you work, you should commit to this branch often, we recommend **every 15 minutes**.
1. Complete the assignment below. You should:
    * TDD all of your work
    * Prioritize getting your code functional before attempting any refactors
    * Write/refactor your code to achieve good code quality

## Submission
The assessment is due by Monday, January 15th at 1pm MT. 
Use [this link](https://docs.google.com/forms/d/e/1FAIpQLSeL09S9ww1L_WtS0EB3fhCM6JEz-hFISuWlgWlB0TMaVK4xAw/viewform) to submit when finished. (If you finish early, you can submit before this time.)

## Assignment

You will build an endpoint that will retrieve variable food and forecast information for a destination city.

Your endpoint should follow this format:

`GET /api/v1/munchies?destination=pueblo,co&food=italian`

Your API will return:
- the destination city & state name as a string
- the name and address of a restaurant serving THE SPECIFIED TYPE of cuisine, plus their Yelp rating and number of reviews
- the current forecast of the destination city (summary, and temperature in degrees Fahrenheit)

Your response should be in the format below:

```json
{
  "data": {
    "id": "null",
    "type": "munchie",
    "attributes": {
      "destination_city": "Pueblo, CO",
      "forecast": {
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83"
      },
      "restaurant": {
        "name": "La Forchetta Da Massi",
        "address": "126 S Union Ave, Pueblo, CO 81003",
        "rating": 4.5,
        "reviews": 148
      }
    }
  }
}
```

## APIs

1. Yelp Fusion API
    - to find the name and address of a restaurant in your end location
        - Restaurants should serve the type of food specified in the request
    - [https://docs.developer.yelp.com/reference/v3_business_search](https://docs.developer.yelp.com/reference/v3_business_search)