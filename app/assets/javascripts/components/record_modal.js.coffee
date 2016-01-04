@RecordModal = React.createClass
  getDefaultProps: ->
    record: {users: []}
    users: []
    type: 'new'
  getInitialState: ->
    title: @props.record.title
    date: dateFormat(@props.record.date)
    amount_sign: if @props.record.amount > 0 then '+' else '-'
    amount: if @props.record.amount < 0 then (-1*@props.record.amount) else @props.record.amount
    payer: @props.record.payer_id
    user_ids: @props.record.users.map (user) -> user.id
  render: ->
    React.DOM.div
      id: @props.dom_id
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
              @modalTitle()
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
                      className: 'form-control rec-form-date'
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
                          className: 'btn btn-default plus-minus-btn'
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
                  className: 'form-control select-picker'
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
                  className: 'form-control select-picker'
                  name: 'user_ids'
                  multiple: true
                  title: ''
                  value: @state.user_ids
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
    $this = $(React.findDOMNode(this))
    $this.find('.rec-form-date').on("changeDate", ((e) ->
      @handleChange(e)
    ).bind(this))
    $this.find('.select-picker').selectpicker()
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": $(e.target).val()
  modalTitle: ->
    switch @props.type
      when 'new' then I18n.t('components.group.new_record')
      when 'edit' then @props.record.title
      else ''
  btnTextClassName: () ->
    switch @state.amount_sign
      when '-' then 'text-danger'
      when '+' then 'text-success'
      else ''
  toggleMinus: () ->
    amount_sign = if (@state.amount_sign == '-') then '+' else '-'
    @setState amount_sign: amount_sign
  valid: ->
    @state.title && @state.date && @state.amount && @state.amount_sign && @state.payer && @state.user_ids && @state.user_ids.length > 0
  handleSubmit: (e) ->
    e.preventDefault()
    switch @props.type
      when 'new' then @createRecord()
      when 'edit' then @editRecord()
      else null
  createRecord: ->
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
      $(React.findDOMNode(this)).find('.select-picker').selectpicker('val','')
      @hideModal()
    , 'JSON'
  editRecord: ->
    record =
      title: @state.title
      date: @state.date
      amount: @state.amount_sign+@state.amount
      payer_id: @state.payer
      user_ids: @state.user_ids
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: record
      success: (data) =>
        @props.handleEditRecord data, @props.record
        @hideModal()
  hideModal: ->
    $("##{@props.dom_id}").modal('hide')