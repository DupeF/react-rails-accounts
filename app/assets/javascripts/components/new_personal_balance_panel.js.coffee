@NewPersonalBalancePanel = React.createClass
  getInitialState: ->
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
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.name
  handleSubmit: (e) ->
    e.preventDefault()
    personal_balance =
      name: @state.name
    $.post '/personal_balances', { personal_balance: personal_balance }, (data) =>
      @props.handleNewBalance data
      @setState @getInitialState()
      @hideModal()
    , 'JSON'
  hideModal: ->
    $('#newBalanceModal').modal('hide')
