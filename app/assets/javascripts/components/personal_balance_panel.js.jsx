var PersonalBalancePanel = React.createClass({
  render: function() {
    return (
      <li className = 'dashboard-entry'>
        <a href = {'/personal_balances/'+this.props.balance.id}>
          <div className = 'panel panel-default dashboard-panel'>
            <div className = 'panel-body dashboard-panel-body'>
              <span className = 'dashboard-panel-title'>
                {this.props.balance.name}
              </span>
            </div>
          </div>
        </a>
      </li>
    );
  }
});
