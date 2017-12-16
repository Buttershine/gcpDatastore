require('dotenv').config();
require('babel-polyfill');
const Router = require('./Router.js');

module.exports = {
  // Top level entry point
  async api(req, res) {
    //TODO: enable cors with nodejs express
    mainApp(req, res);
  }

};

function mainApp(req, res) {
  res.setHeader('Content-Type', 'application/json');
  try {
    Router.route(req, res);
  } catch (e) {
    console.log(e);
    res.status(422).send({ errors: { body: [e.message], } });
  }
}
