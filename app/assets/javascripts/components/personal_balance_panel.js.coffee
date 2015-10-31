@PersonalBalancePanel = React.createClass
  render: ->
    React.DOM.li
      key: @props.balance.id
      React.DOM.a
        href: '/personal_balances/'+@props.balance.id
        @props.balance.name
