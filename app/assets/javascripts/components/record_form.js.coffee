@RecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
    group_id: @props.group_id
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          id: 'rec-form-date'
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
    $('#rec-form-date').on("changeDate", ((e) ->
      @handleChange(e)
    ).bind(this))
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.date && @state.amount
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/records', { record: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'