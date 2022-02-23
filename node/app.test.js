const app = require("./app");

describe("spendings", () => {
    it("returns a list of spendings", () => {
        expect(app.today()).toBe(new Date().toLocaleDateString());
    });
});
