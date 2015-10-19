
@PersonalBalance = React.createClass
  getInitialState: ->
    records: @props.records
    total_pages: @props.total_pages
  getDefaultProps: ->
    records: []
  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        I18n.t('components.personal_balance.title')
      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', amount: @credits(), text: I18n.t('components.amount_box.credit')
        React.createElement AmountBox, type: 'danger', amount: @debits(), text: I18n.t('components.amount_box.debit')
        React.createElement AmountBox, type: 'info', amount: @balance(), text: I18n.t('components.amount_box.balance')
      React.createElement PersonalRecordForm, balance_id: @props.balance_id, handleNewRecord: @addRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, I18n.t('components.date')
            React.DOM.th null, I18n.t('components.title')
            React.DOM.th null, I18n.t('components.amount')
            React.DOM.th null, I18n.t('components.actions')
        React.DOM.tbody null,
          for record in @state.records
            React.createElement PersonalRecord, key: record.id, record: record, handleEditRecord: @updateRecord, handleDeleteRecord: @deleteRecord
      React.createElement ReactPaginate, max: @state.total_pages, maxVisible: @state.total_pages, onChange: @changePage
  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  balance: ->
    @debits() + @credits()
  changePage: (page) ->
    $.get '/personal_balance', { page: page }, (data) =>
      @setState records: data.records, total_pages: data.total_pages
    , 'JSON'
  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records
  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]]})
    @replaceState records: records
  deleteRecord: (record) ->
    index = @state.records.indexOf  record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState  records: records