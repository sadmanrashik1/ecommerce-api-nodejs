// utils/filterAllowedFields.js

// /**
//  * Creates an updates object with only allowed fields from req.body
//  * @param {Object} body - req.body
//  * @param {string[]} allowedFields - array of permitted field names
//  * @returns {Object} filtered updates object
//  */


const filterAllowedFields = (body, allowedFields) => {
  const updates = {};

  allowedFields.forEach((field) => {
    if (body[field] !== undefined) {
      updates[field] = body[field];
    }
  });

  return updates;
};

module.exports =  filterAllowedFields ;