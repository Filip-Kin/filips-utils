const bent = require('bent');
const csvtojson = require('csvtojson');
const { Parser } = require('json2csv');
const { writeFileSync } = require('fs');

const getJSON = bent('json');

const getStats = async (username) => {
    return await getJSON('https://stats.foldingathome.org/api/donor/'+username);
}

const recordStats = async (username, userStats) => {
    let stats = await getStats(username)
    userStats.push({
        datetime: getDatetime(),
        'work units': stats.wus,
        points: stats.credit,
        rank: stats.rank,
        'total users': stats.total_users
    });
    writeFileSync('userStats.csv', jsontocsv.parse(userStats));
    console.log('Rank '+stats.rank);
}

const getDatetime = () => {
    let d = new Date();
    return d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds();
}

const jsontocsv = new Parser();
csvtojson().fromFile('userStats.csv').then(async (userStats) => {
    setInterval(() => recordStats('filip96', userStats), 5*60*1000);
    recordStats('filip96', userStats);
});
