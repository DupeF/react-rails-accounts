@PersonalBalance = React.createClass
  getInitialState: ->
    page: @props.page
    records: @props.records
    total_pages: @props.total_pages
    total_credits: @props.total_credits
    total_debits: @props.total_debits
  getDefaultProps: ->
    balance: {}
    page: 1
    records: []
    total_pages: 1
    total_credits: 0
    total_debits: 0
  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        @props.balance.name
      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', page_amount: @page_credits(), total_amount: @state.total_credits, text: I18n.t('components.amount_box.credit')
        React.createElement AmountBox, type: 'danger', page_amount: @page_debits(), total_amount: @state.total_debits, text: I18n.t('components.amount_box.debit')
        React.createElement AmountBox, type: 'info', page_amount: @page_balance(), total_amount: @total_balance(), text: I18n.t('components.amount_box.balance')
      React.createElement PersonalRecordForm, balance_id: @props.balance.id, handleNewRecord: @createRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th
              className: 'col-md-3'
              I18n.t('components.date')
            React.DOM.th
              className: 'col-md-3'
              I18n.t('components.title')
            React.DOM.th
              className: 'col-md-3'
              I18n.t('components.amount')
            React.DOM.th
              className: 'col-md-3'
              I18n.t('components.actions')
        React.DOM.tbody null,
          for record in @state.records
            React.createElement PersonalRecord, key: record.id, record: record, handleEditRecord: @updateRecord, handleDeleteRecord: @destroyRecord
      React.createElement ReactPaginate, max: @state.total_pages, maxVisible: @state.total_pages, onChange: @reloadRecords
  page_credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  page_debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  page_balance: ->
    @page_debits() + @page_credits()
  total_balance: ->
    @state.total_credits + @state.total_debits
  createRecord: (record) ->
    @addToTotals record.amount
    @reloadRecords()
  updateRecord: (new_record, old_record) ->
    @removeFromTotals old_record.amount
    @addToTotals new_record.amount
    @reloadRecords()
  destroyRecord: (record) ->
    @removeFromTotals record.amount
    @reloadRecords()
  reloadRecords: (page) ->
    if page == undefined
      page = @state.page
    path = '/personal_balances/'+@props.balance.id
    $.get path, { page: page }, (data) =>
      records = React.addons.update @state.records, {$set: data.records}
      @setState page: page, records: records, total_pages: data.total_pages
    , 'JSON'
  addToTotals: (amount) ->
    if amount >= 0
      @setState total_credits: (@state.total_credits+amount)
    else
      @setState total_debits: (@state.total_debits+amount)
  removeFromTotals: (amount) ->
    if amount >= 0
      @setState total_credits: (@state.total_credits-amount)
    else
      @setState total_debits: (@state.total_debits-amount)
