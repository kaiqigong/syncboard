/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Figure = require('./figure.model');

exports.register = function(socket) {
  Figure.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Figure.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('figure:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('figure:remove', doc);
}
