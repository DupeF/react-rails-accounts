@PersonalBalancePanel = React.createClass
  render: ->
    React.DOM.li null,
      React.DOM.div
        className: 'panel panel-default personal-balance-panel'
        React.DOM.a
          href: '/personal_balances/'+@props.balance.id
          React.DOM.div
            className: 'panel-body'
            @props.balance.name
