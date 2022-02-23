const request = require("supertest");
const app = require("./app");

describe("/spendings", () => {
  test("It should response the GET method", done => {
    request(app)
      .get("/spendings")
      .then(response => {
        expect(response.statusCode).toBe(200);
        done();
      });
  });
});
