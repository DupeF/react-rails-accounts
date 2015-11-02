@Dashboard = React.createClass
  getDefaultProps: ->
    balances: []
  render: ->
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col-md-8 col-md-offset-2'
        React.DOM.ul
          className: 'list list-unstyled'
          for balance in @props.balances
            React.createElement PersonalBalancePanel, key: balance.id, balance: balance