@Dashboard = React.createClass
  getDefaultProps: ->
    balances: []
  getInitialState: ->
    balances: @props.balances
  render: ->
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col-md-8 col-md-offset-2'
        React.DOM.ul
          className: 'list list-unstyled'
          for balance in @state.balances
            React.createElement PersonalBalancePanel, key: balance.id, balance: balance
          React.createElement NewPersonalBalancePanel, handleNewBalance: @addBalance
  addBalance: (balance) ->
    balances = React.addons.update(@state.balances, { $push: [balance] })
    @setState balances: balances