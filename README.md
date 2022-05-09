# PerfectRec Take-Home Test
Thank you for your interest in joining PerfectRec!

This take-home assignment consists of a full-stack web application which runs in Docker. Your task is to add a few features to the application.

The stack primarily consists of:
* NextJS
* React
* Tailwind CSS
* GraphQL
* PostgreSQL

## Instructions
In total, this assignment should take 3-4 hours to complete. If you cannot complete the assignment within that time, do not worry! In that case, please add a new file to the repo named `PROGRESS.md` which briefly describes what you would do next if you were to have the time, as well as anything you found to be particularly challenging about the assignment.

Without further adieu, it's time to start coding! First, get the local application running via instructions in [Setup](#setup), and then you can work on the following features. Also take note that there are some useful [Development Tips](#development-tips) at the bottom!

### Feature #1
The primary goal of the web application is to present the user with sequence of multiple-choice questions (one question visible at a time) in order to make a product recommendation based on the answers. Your first feature is to support presenting questions to the user based on their definitions in the database. You do _not_ need to support making a product recommendation.

A very basic start to this feature already exists in `src/pages/index.tsx`, which queries the server for the list of questions for a specific product category (Laptops). You need to complete the feature such that the user is asked each question one by one, and is able to choose one of the multipe-choice answers for each question. You can assume that the only type of question that exists is multiple-choice, and you do _not_ need to record the answers to the database yet.

This feature requires coding across the stack, including UI changes, GraphQL endpoint changes, writing DB queries, etc.

### Feature #2
The next step is to actually store each answer into the database. This should be done each time the user answers a question, rather than at the end of the sequence of questions. There already exists a `responses` table, which is where each response shall be stored. Each response is attached to a `response_set` and a `session`.

For the purposes of this assignment, you should hardcode a static `session` ID (`"8a042805-6738-4806-9456-8405974c9b40"` as used in `flyway/data/V1.0.1__data.sql`), but you should create a new `response_set` record each time that the user is starting to answer the sequence of questions for the fist time. For example, upon answering the very first question, a new `response_set` should be created and then referenced by the `response` entry that stores their selected response to the question. Each subsequent question should have its response stored into the same set, until the final question is completed.

### Other Considerations
While you are implementing the features above, keep in mind the various considerations that are important when writing a production application. For example, security, clean architecture, readability / maintainability, error handling, and scalability. In any way you see fit, you are encouraged to modify the application in order to make improvements to these aspects, and if time permits, please also leave comments in the code about such changes.

## Setup
You only need a machine which can install a modern version of Docker! All local development is done within Docker containers via Docker Compose.

1. Clone this repository and create a branch based on your name (e.g. `john-doe`).
1. Install Docker natively. If you are on a Mac, we recommend [Docker Desktop](https://www.docker.com/products/docker-desktop/).
1. Install dependencies by running `yarn`. These are actually only useful for local IDE work
   (e.g. VSCode) such that it can resolve dependencies. These will _not_ be used by the running
   application.
1. Run `yarn docker:up`
1. Access the site via http://localhost:3000

To shell into the running application container, run `yarn docker:shell`.

To get a `psql` CLI into the running PostgreSQL DB, run `yarn docker:db`.

## Development Tips
The full database schema is already defined for you in `flyway/schema/V1.0.0__initial_schemal.sql`. You do not need to modify this file, but it useful to look at in order to understand the data model.

The initial data set is already defined for you in `flyway/data/V1.0.1__data.sql`. You do not need to modify this file.
