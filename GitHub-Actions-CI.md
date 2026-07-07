# Phase 2 - Task 2: Continuous Integration (CI) using GitHub Actions

## Objective

Implement a GitHub Actions CI pipeline that: - Triggers on Push and Pull
Requests - Installs dependencies - Runs unit tests - Performs a build

## Repository Structure

``` text
enterprise-devops-capstone/
├── app/
│   ├── src/app.js
│   ├── tests/app.test.js
│   ├── package.json
│   └── server.js
└── .github/workflows/ci.yml
```

## Create Project

``` bash
mkdir enterprise-devops-capstone
cd enterprise-devops-capstone
mkdir app
cd app
npm init -y
npm install express
npm install --save-dev jest supertest
mkdir src tests
touch src/app.js tests/app.test.js server.js
```

## Source Code

### src/app.js

``` javascript
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.status(200).send("Hello from Enterprise DevOps Capstone");
});

module.exports = app;
```

### server.js

``` javascript
const app = require("./src/app");
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Application running on port ${PORT}`);
});
```

### package.json scripts

``` json
"scripts": {
  "start": "node server.js",
  "test": "jest",
  "build": "echo Build Successful"
}
```

### tests/app.test.js

``` javascript
const request = require("supertest");
const app = require("../src/app");

describe("GET /", () => {
  it("should return Hello from Enterprise DevOps Capstone", async () => {
    const response = await request(app).get("/");
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe("Hello from Enterprise DevOps Capstone");
  });
});
```

## Test

``` bash
npm install
npm start
npm test
npm run build
```

## GitHub Actions Workflow

Create `.github/workflows/ci.yml`

``` yaml
name: Continuous Integration

on:
  push:
    branches:
      - develop
      - main

  pull_request:
    branches:
      - develop

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup NodeJS
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Install Packages
        run: npm install

      - name: Run Tests
        run: npm test

      - name: Build Application
        run: npm run build
```

## Deliverables

-   Node.js source code
-   ci.yml
-   Successful GitHub Actions build
-   Build logs

