@PersonalBalancePanel = React.createClass
  render: ->
    React.DOM.li
      className: 'dashboard-entry'
      React.DOM.a
        href: '/personal_balances/'+@props.balance.id
        React.DOM.div
          className: 'panel panel-default dashboard-panel'
          React.DOM.div
            className: 'panel-body dashboard-panel-body'
            React.DOM.span
              className: 'dashboard-panel-title'
              @props.balance.name
