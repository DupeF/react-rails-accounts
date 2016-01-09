var GroupPanel = React.createClass({
  render: function() {
    return (
      <li className = 'dashboard-entry'>
        <a href = {'/groups/'+this.props.group.id}>
          <div className = 'panel panel-default dashboard-panel'>
            <div className = 'panel-body dashboard-panel-body'>
              <span className = 'dashboard-panel-title'>
                {this.props.group.name}
              </span>
            </div>
          </div>
        </a>
      </li>
    );
  }
});
