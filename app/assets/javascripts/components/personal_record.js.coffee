@PersonalRecord = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, dateFormat(@props.record.date)
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          I18n.t('components.edit')
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          I18n.t('components.delete')
  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          'data-provide': 'datepicker'
          defaultValue: dateFormat(@props.record.date)
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.amount
          ref: 'amount'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          I18n.t('components.update')
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          I18n.t('components.cancel')
  handleEdit: (e) ->
    e.preventDefault()
    data = 
      title: React.findDOMNode(@refs.title).value
      date: React.findDOMNode(@refs.date).value
      amount: React.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/personal_records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        personal_record: data
      success: () =>
        @setState edit: false
        @props.handleEditRecord()
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/personal_records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord()