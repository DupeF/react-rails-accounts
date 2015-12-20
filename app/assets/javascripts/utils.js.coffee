@amountFormat = (amount) ->
  Number(amount).toLocaleString() + ' €'

@dateFormat = (date) ->
  if date == undefined then return ''
  date = new Date(date)
  day = ("0" + (date.getDate())).slice(-2)
  month = ("0" + (date.getMonth() +　1)).slice(-2)
  year = date.getFullYear()
  return day+'/'+month+'/'+year
