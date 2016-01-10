var amountFormat = function(amount) {
  return (Number(amount).toLocaleString()+' €');
};

var dateFormat = function(date) {
  if (date == undefined) { return ''; }
  var parsed_date = new Date(date);
  var day = ("0" + (parsed_date.getDate())).slice(-2);
  var month = ("0" + (parsed_date.getMonth() +　1)).slice(-2);
  var year = parsed_date.getFullYear();
  return (day+'/'+month+'/'+year);
};
