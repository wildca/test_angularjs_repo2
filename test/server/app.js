/*eslint no-unused-expressions:0*/
'use strict';

var expect = require('chai').expect;
var app = require('../../server/app');

describe('server', function () {
  describe('server tests', function () {
    it('should exist', function () {
      expect(app).to.exist;
    });
  });
});
