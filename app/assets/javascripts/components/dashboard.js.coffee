@Dashboard = React.createClass
  getDefaultProps: ->
    balances: []
    groups: []
  getInitialState: ->
    balances: @props.balances
    groups: @props.groups
  render: ->
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col-md-8 col-md-offset-2'
        React.DOM.ul
          className: 'list list-unstyled'
          for balance in @state.balances
            React.createElement PersonalBalancePanel, key: 'balance'+balance.id, balance: balance
          for group in @state.groups
            React.createElement GroupPanel, key: 'group'+group.id, group: group
          React.createElement NewBalancePanel, handleNewBalance: @addBalance, handleNewGroup: @addGroup
  addBalance: (balance) ->
    balances = React.addons.update(@state.balances, { $push: [balance] })
    @setState balances: balances
  addGroup: (group) ->
    groups = React.addons.update(@state.groups, { $push: [group] })
    @setState groups: groups