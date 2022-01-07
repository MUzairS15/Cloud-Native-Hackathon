const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');

const serviceAccount = require('<path to your service-key.json file>');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

module.exports = db;