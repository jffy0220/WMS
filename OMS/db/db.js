const {Pool} = require('pg');

/*
    Obviously this is for development purposes only, you'd never host usernames/passwords to databases like this
*/
const pool = new Pool({
    user: 'user',
    host: 'localhost',
    database: 'warehouse',
    password: 'password',
    port: 5432
});

module.exports = pool;