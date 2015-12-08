@RecordModal = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount_sign: '-'
    amount: ''
    payer: ''
    user_ids: null
  render: ->
    React.DOM.div
      id: 'newRecordModal'
      className: 'modal fade'
      React.DOM.div
        className: 'modal-dialog'
        React.DOM.div
          className: 'modal-content'
          React.DOM.div
            className: 'modal-header'
            React.DOM.button
              type: 'button'
              className: 'close'
              'data-dismiss': 'modal'
              'aria-hidden': 'true'
              'x'
            React.DOM.h4
              className: 'modal-title'
              I18n.t('components.group.new_record')
          React.DOM.form
            onSubmit: @handleSubmit
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'form-group'
                React.DOM.label null,
                  I18n.t('components.title')
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
                  className: 'row'
                  React.DOM.div
                    className: 'col-md-6'
                    React.DOM.label null,
                      I18n.t('components.date')
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
                    className: 'col-md-6'
                    React.DOM.label null,
                      I18n.t('components.amount')
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
              React.DOM.div
                className: 'form-group'
                React.DOM.label null,
                  I18n.t('components.payed_by')
                React.DOM.select
                  className: 'form-control selectpicker'
                  name: 'payer'
                  value: @state.payer
                  onChange: @handleChange
                  React.DOM.option
                    className: 'hidden'
                    value: ''
                    ' '
                  for user in @props.users
                    React.DOM.option
                      key: user.id
                      value: user.id
                      user.email
              React.DOM.div
                className: 'form-group'
                React.DOM.label null,
                  I18n.t('components.payed_for')
                React.DOM.select
                  className: 'form-control selectpicker'
                  name: 'user_ids'
                  multiple: true
                  title: ''
                  onChange: @handleChange
                  for user in @props.users
                    React.DOM.option
                      key: user.id
                      value: user.id
                      user.email
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                type: 'submit'
                className: 'btn btn-primary'
                disabled: !@valid()
                I18n.t('components.dashboard.new_balance.save')
  componentDidMount: () ->
    $('#rec-form-date').on("changeDate", ((e) ->
      @handleChange(e)
    ).bind(this))
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": $(e.target).val()
  btnTextClassName: () ->
    switch @state.amount_sign
      when '-' then 'text-danger'
      when '+' then 'text-success'
      else ''
  toggleMinus: () ->
    amount_sign = if (@state.amount_sign == '-') then '+' else '-'
    @setState amount_sign: amount_sign
  valid: ->
    @state.title && @state.date && @state.amount && @state.amount_sign && @state.payer && @state.user_ids
  handleSubmit: (e) ->
    e.preventDefault()
    record =
      title: @state.title
      date: @state.date
      amount: @state.amount_sign+@state.amount
      payer_id: @state.payer
      user_ids: @state.user_ids
      group_id: @props.group_id
    $.post '/records', { record: record }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
      $('.selectpicker').selectpicker('val','')
      @hideModal()
    , 'JSON'
  hideModal: ->
    $('#newRecordModal').modal('hide')