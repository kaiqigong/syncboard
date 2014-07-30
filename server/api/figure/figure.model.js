'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var FigureSchema = new Schema({
  data: String,
});

module.exports = mongoose.model('Figure', FigureSchema);
