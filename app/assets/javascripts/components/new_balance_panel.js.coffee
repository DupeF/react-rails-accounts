@NewBalancePanel = React.createClass
  getInitialState: ->
    type: ''
    name: ''
  render: ->
    React.DOM.li
      className: 'dashboard-entry'
      React.DOM.a
        href: '#newBalanceModal'
        role: 'button'
        'data-toggle': 'modal'
        React.DOM.div
          className: 'panel panel-default dashboard-panel'
          React.DOM.div
            className: 'panel-body dashboard-panel-body'
            React.DOM.span
              className: 'dashboard-panel-title'
              I18n.t('components.dashboard.new_balance.title')
      React.DOM.div
        id: 'newBalanceModal'
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
                I18n.t('components.dashboard.new_balance.title')
            React.DOM.form
              onSubmit: @handleSubmit
              React.DOM.div
                className: 'modal-body'
                React.DOM.div
                  className: 'form-group'
                  React.DOM.div
                    className: 'row'
                    React.DOM.div
                      className: 'col-md-6'
                      React.DOM.button
                        className: @typeButtonClass('personal_balance')
                        onClick: @setType('personal_balance')
                        React.DOM.i
                          className: 'fa fa-user'
                    React.DOM.div
                      className: 'col-md-6'
                      React.DOM.button
                        className: @typeButtonClass('group')
                        onClick: @setType('group')
                        React.DOM.i
                          className: 'fa fa-users'
                React.DOM.div
                  className: 'form-group'
                  React.DOM.label
                    htmlFor: 'nameInputNewPersonalBalance'
                    I18n.t('components.dashboard.new_balance.name')
                  React.DOM.input
                    type: 'text'
                    id: 'nameInputNewPersonalBalance'
                    className: 'form-control'
                    placeholder: ''
                    name: 'name'
                    value: @state.name
                    onChange: @handleChange
              React.DOM.div
                className: 'modal-footer'
                React.DOM.button
                  type: 'submit'
                  className: 'btn btn-primary'
                  disabled: !@valid()
                  I18n.t('components.dashboard.new_balance.save')
  typeButtonClass: (type) ->
    buttonClass = 'btn btn-default btn-lg btn-block'
    if type == @state.type
      buttonClass += ' active'
    return buttonClass
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  setType: (type) ->
    ( (e) ->
      e.preventDefault()
      @setState type: type
    ).bind(this)
  valid: ->
    @state.type && @state.name
  handleSubmit: (e) ->
    e.preventDefault()
    path = @pathFromType()
    params =
      name: @state.name
    $.post path, { "#{ @state.type }": params }, (data) =>
      switch @state.type
        when 'personal_balance' then @props.handleNewBalance data
        when 'group' then @props.handleNewGroup data
      @setState @getInitialState()
      @hideModal()
    , 'JSON'
  pathFromType: ->
    switch @state.type
      when 'personal_balance' then '/personal_balances'
      when 'group' then '/groups'
      else ''
  hideModal: ->
    $('#newBalanceModal').modal('hide')
