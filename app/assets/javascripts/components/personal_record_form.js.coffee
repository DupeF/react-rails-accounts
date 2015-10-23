@PersonalRecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount_sign: '-'
    amount: ''
    personal_balance_id: @props.balance_id
  render: ->
    React.DOM.form
      className: 'form-inline'
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
              className: @btnClassName()
              type: 'button'
              onClick: @toggleMinus
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
  btnClassName: () ->
    color_class = switch @state.amount_sign
      when '-' then 'btn-danger'
      when '+' then 'btn-success'
      else 'btn-default'
    'plus-minus-btn btn '+color_class
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
      personal_balance_id: @state.personal_balance_id
    $.post '/personal_records', { personal_record: personal_record }, () =>
      @props.handleNewRecord()
      @setState @getInitialState()
    , 'JSON'
