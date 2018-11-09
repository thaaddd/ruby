# Uploaded Transactions Manager

This tool allows real estate agents to upload and manager their past real estate transactions.

## Tech
* Ruby 2.4.1
* Rails 5.1.4
* SQLite

## Setup
* Have the tech installed in the dev env
* Clone the repo locally
* Run `bundle install`
* Run `db:setup`
* Run `rails server`
* Navigate to `localhost:3000`

## Assignments (choose at least 2)
1. Build a bulk transaction uploader - allow agents to upload a CSV where each row represents a new transaction
  * Each column should represent the columns in the model
  * De-dupe on `address`, `zip` and `selling_date`
2. Add model and client-side validation and add styling to the form.
3. Paginate the transactions list on the agent profile page
4. Sort the transactions list on the agent profile page by selling_date but sort transactions where the `property_type` is "land" or "mobile_home" at the bottom of the list
5. Build filtering and sorting controls to the transaction list on the agent profile
6. Optimize / speed up the `UploadedTransaction` queries - assume there are 10 million rows in that table
So there's a couple of things going on here that I'd like to expand on. I haven't coded anything up but I'm fascinated by scaling questions. One obvious way to speed this up is to add indexes to the two foreign keys (listing_agent_id, selling_agent_id) on uploaded_transactions.

Also, clustering on an index is necessary. I'm not sure what would be the best index to cluster on, with the query as it is now, probably a composite index of listing_agent_id and selling_agent_id meaning you could remove the extraneous listing_agent_id.

Also there is the issue of pagination. Since order bys and pagination don't play well together it'd probably be smarter to do exclusively front end pagination. The limiting factor in this is the amount of data in the query. You don't want to send up hundreds or thousands of rows in a single query but we could easily add a drop down on yearly transactions and there is the inherent limiting factor on the number of transactions a single agent can do in a year.

Also, we'd probably change the all_transactions property from a select * to only querying the properties that we'd need using pluck.

I tried playing around with the query -> changing the or to two separate queries with a union or doing a join on agents but I wasn't seeing too much improvement but that's a possibility as well.

For uploading new transactions (definitely bulk and probably single), I'd make it asynchronous.

7. Allow the agent to select which side of the transaction they represented (seller, buyer or both)
8. Increase test coverage and add front-end testing
