var Dashboard = React.createClass({
  getDefaultProps: function() {
    return {
      balances: [],
      groups: []
    };
  },
  getInitialState: function() {
    return {
      balances: this.props.balances,
      groups: this.props.groups
    };
  },
  render: function() {
    return (
      <div className = 'row'>
        <div className = 'col-md-8 col-md-offset-2'>
          <ul className = 'list list-unstyled'>
            {this.state.balances.map(function(balance) {
              return <PersonalBalancePanel key={'balance'+balance.id} balance={balance}/>;
            })}
            {this.state.groups.map(function(group) {
              return <GroupPanel key={'group'+group.id} group={group}/>;
            })}
            <NewBalancePanel handleNewBalance = {this.addBalance} handleNewGroup = {this.addGroup}/>
          </ul>
        </div>
      </div>
    );
  },
  addBalance: function(balance) {
    var balances = React.addons.update(this.state.balances, { $push: [balance] });
    this.setState({balances: balances});
  },
  addGroup: function(group) {
    var groups = React.addons.update(this.state.groups, { $push: [group] });
    this.setState({groups: groups});
  }
});
