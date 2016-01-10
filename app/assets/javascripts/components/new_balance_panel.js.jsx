var NewBalancePanel = React.createClass({
  getInitialState: function() {
    return {
      type: '',
      name: ''
    };
  },
  render: function() {
    return (
      <li className = 'dashboard-entry'>
        <a href = '#newBalanceModal'
           role = 'button'
           data-toggle = 'modal'>
          <div className = 'panel panel-default dashboard-panel'>
            <div className = 'panel-body dashboard-panel-body'>
              <span className = 'dashboard-panel-title'>{I18n.t('components.dashboard.new_balance.title')}</span>
            </div>
          </div>
        </a>
        <div id = 'newBalanceModal'
             className = 'modal fade'>
          <div className = 'modal-dialog'>
            <div className = 'modal-content'>
              <div className = 'modal-header'>
                <button type = 'button'
                        className = 'close'
                        data-dismiss = 'modal'
                        aria-hidden = 'true'>x</button>
                <h4 className = 'modal-title'>{I18n.t('components.dashboard.new_balance.title')}</h4>
              </div>
              <form onSubmit = {this.handleSubmit}>
                <div className = 'modal-body'>
                  <div className = 'form-group'>
                    <div className = 'row'>
                      <div className = 'col-md-6'>
                        <button className = {this.typeButtonClass('personal_balance')}
                                onClick = {this.setType('personal_balance')}>
                          <i className = 'fa fa-user'/>
                        </button>
                      </div>
                      <div className = 'col-md-6'>
                        <button className = {this.typeButtonClass('group')}
                                onClick = {this.setType('group')}>
                          <i className = 'fa fa-users'/>
                        </button>
                      </div>
                    </div>
                  </div>
                  <div className = 'form-group'>
                    <label htmlFor = 'nameInputNewPersonalBalance'>
                      {I18n.t('components.dashboard.new_balance.name')}
                    </label>
                    <input type = 'text'
                           id = 'nameInputNewPersonalBalance'
                           className = 'form-control'
                           placeholder = ''
                           name = 'name'
                           value = {this.state.name}
                           onChange = {this.handleChange}/>
                  </div>
                </div>
                <div className = 'modal-footer'>
                  <button type = 'submit'
                          className = 'btn btn-primary'
                          disabled = {!this.valid()}>
                    {I18n.t('components.dashboard.new_balance.save')}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </li>
    );
  },
  typeButtonClass: function(type) {
    var buttonClass = 'btn btn-default btn-lg btn-block';
    if (type == this.state.type) {
      buttonClass += ' active';
    }
    return buttonClass;
  },
  handleChange: function(e) {
    var stateArgs = {};
    stateArgs[e.target.name] = e.target.value;
    this.setState(stateArgs);
  },
  setType: function(type) {
    return (function(e) {
      e.preventDefault();
      this.setState({type: type});
    }).bind(this);
  },
  valid: function() {
    return (this.state.type && this.state.name);
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var path = this.pathFromType();
    var params = {};
    params[this.state.type] = { name: this.state.name };
    $.post(path, params, (function(data) {
      switch(this.state.type) {
        case 'personal_balance':
          this.props.handleNewBalance(data);
          break;
        case 'group':
          this.props.handleNewGroup(data);
          break;
      }
      this.setState(this.getInitialState());
      this.hideModal();
    }).bind(this), 'JSON');
  },
  pathFromType: function() {
    switch(this.state.type) {
      case 'personal_balance':
        return '/personal_balances';
      case 'group':
        return '/groups';
      default:
        return '';
    }
  },
  hideModal: function() {
    $('#newBalanceModal').modal('hide');
  }
});
