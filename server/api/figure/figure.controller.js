'use strict';

var _ = require('lodash');
var Figure = require('./figure.model');

// Get list of figures
exports.index = function(req, res) {
  Figure.find(function (err, figures) {
    if(err) { return handleError(res, err); }
    return res.json(200, figures);
  });
};

// Get a single figure
exports.show = function(req, res) {
  Figure.findById(req.params.id, function (err, figure) {
    if(err) { return handleError(res, err); }
    if(!figure) { return res.send(404); }
    return res.json(figure);
  });
};

// Creates a new figure in the DB.
exports.create = function(req, res) {
  Figure.create(req.body, function(err, figure) {
    if(err) { return handleError(res, err); }
    return res.json(201, figure);
  });
};

// Updates an existing figure in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Figure.findById(req.params.id, function (err, figure) {
    if (err) { return handleError(err); }
    if(!figure) { return res.send(404); }
    var updated = _.merge(figure, req.body);
    updated.save(function (err) {
      if (err) { return handleError(err); }
      return res.json(200, figure);
    });
  });
};

// Deletes a figure from the DB.
exports.destroy = function(req, res) {
  Figure.findById(req.params.id, function (err, figure) {
    if(err) { return handleError(res, err); }
    if(!figure) { return res.send(404); }
    figure.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}