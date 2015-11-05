@PersonalRecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount_sign: '-'
    amount: ''
  render: ->
    React.DOM.form
      className: 'form-inline record-form'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          id: 'pers-rec-form-date'
          className: 'form-control'
          'data-provide': 'datepicker'
          placeholder: I18n.t('components.date')
          name: 'date'
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: I18n.t('components.title')
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.div
          className: 'input-group'
          React.DOM.span
            className: 'input-group-btn'
            React.DOM.button
              id: 'plus-minus-btn'
              className: 'btn btn-default'
              type: 'button'
              onClick: @toggleMinus
              React.DOM.span
                className: @btnTextClassName()
                @state.amount_sign
          React.DOM.input
            type: 'number'
            className: 'form-control'
            placeholder: I18n.t('components.amount')
            name: 'amount'
            value: @state.amount
            onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className:  'btn btn-primary'
        disabled: !@valid()
        I18n.t('components.record_form.create')
  componentDidMount: () ->
    $('#pers-rec-form-date').on("changeDate", ((e) ->
      @handleChange(e)
    ).bind(this))
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  btnTextClassName: () ->
    switch @state.amount_sign
      when '-' then 'text-danger'
      when '+' then 'text-success'
      else ''
  toggleMinus: () ->
    amount_sign = if (@state.amount_sign == '-') then '+' else '-'
    @setState amount_sign: amount_sign
  valid: ->
    @state.title && @state.date && @state.amount && @state.amount_sign
  handleSubmit: (e) ->
    e.preventDefault()
    personal_record =
      title: @state.title
      date: @state.date
      amount: @state.amount_sign+@state.amount
      personal_balance_id: @props.personal_balance_id
    $.post '/personal_records', { personal_record: personal_record }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'
