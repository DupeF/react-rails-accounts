var RecordModal = React.createClass({
  getDefaultProps: function() {
    return {
      record: {users: []},
      users: [],
      type: 'new'
    };
  },
  getInitialState: function() {
    return {
      title: this.props.record.title,
      date: dateFormat(this.props.record.date),
      amount_sign: ( (this.props.record.amount < 0) ? '-' : '+' ),
      amount: ( (this.props.record.amount < 0) ? (-1*this.props.record.amount) : this.props.record.amount ),
      payer: this.props.record.payer_id,
      user_ids: this.props.record.users.map(function(user) { return user.id; })
    };
  },
  render: function() {
    return (
      <div id = {this.props.dom_id} className = 'modal fade'>
        <div className = 'modal-dialog'>
          <div className = 'modal-content'>
            <div className = 'modal-header'>
              <button type = 'button'
                      className = 'close'
                      data-dismiss = 'modal'
                      aria-hidden = 'true'>x</button>
              <h4 className = 'modal-title'>{this.modalTitle()}</h4>
            </div>
            <form onSubmit = {this.handleSubmit}>
              <div className = 'modal-body'>
                <div className = 'form-group'>
                  <label>{I18n.t('components.title')}</label>
                  <input type = 'text'
                         className = 'form-control'
                         placeholder = {I18n.t('components.title')}
                         name = 'title'
                         value = {this.state.title}
                         onChange = {this.handleChange} />
                </div>
                <div className = 'form-group'>
                  <div className = 'row'>
                    <div className = 'col-md-6'>
                      <label>{I18n.t('components.date')}</label>
                      <input type = 'text'
                             className = 'form-control rec-form-date'
                             data-provide = 'datepicker'
                             placeholder = {I18n.t('components.date')}
                             name = 'date'
                             value = {this.state.date}
                             onChange = {this.handleChange} />
                    </div>
                    <div className = 'col-md-6'>
                      <label>{I18n.t('components.amount')}</label>
                      <div className = 'input-group'>
                        <span className = 'input-group-btn'>
                          <button className = 'btn btn-default plus-minus-btn'
                                  type = 'button'
                                  onClick = {this.toggleMinus}>
                            <span className = {this.btnTextClassName()}>{this.state.amount_sign}</span>
                          </button>
                        </span>
                        <input type = 'number'
                               className = 'form-control'
                               placeholder = {I18n.t('components.amount')}
                               name = 'amount'
                               value = {this.state.amount}
                               onChange = {this.handleChange} />
                      </div>
                    </div>
                  </div>
                </div>
                <div className = 'form-group'>
                  <label>{I18n.t('components.payed_by')}</label>
                  <select className = 'form-control select-picker'
                          name = 'payer'
                          value = {this.state.payer}
                          onChange = {this.handleChange}>
                    <option className = 'hidden' value = ''> </option>
                    {this.props.users.map(function(user) {
                      return (<option key = {user.id} value = {user.id}>{user.email}</option>);
                    })}
                  </select>
                </div>
                <div className = 'form-group'>
                  <label>{I18n.t('components.payed_for')}</label>
                  <select className = 'form-control select-picker'
                          name = 'user_ids'
                          title = ''
                          value = {this.state.user_ids}
                          onChange = {this.handleChange}
                          multiple>
                    {this.props.users.map(function(user) {
                      return (<option key = {user.id} value = {user.id}>{user.email}</option>);
                    })}
                  </select>
                </div>
              </div>
              <div className = 'modal-footer'>
                <button className = 'btn btn-primary'
                        type = 'submit'
                        disabled = {!this.valid()}>
                  {I18n.t('components.dashboard.new_balance.save')}
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  },
  componentDidMount: function() {
    var $this = $(React.findDOMNode(this));
    $this.find('.rec-form-date').on("changeDate", (function(e) {
      this.handleChange(e);
    }).bind(this));
    $this.find('.select-picker').selectpicker();
  },
  handleChange: function(e) {
    var stateArgs = {};
    stateArgs[e.target.name] = $(e.target).val();
    this.setState(stateArgs);
  },
  modalTitle: function() {
    switch(this.props.type) {
      case 'new':
        return I18n.t('components.group.new_record');
      case 'edit':
        return this.props.record.title;
      default:
        return '';
    }
  },
  btnTextClassName: function() {
    switch(this.state.amount_sign) {
      case '-':
        return 'text-danger';
      case '+':
        return 'text-success';
      default:
        return  '';
    }
  },
  toggleMinus: function() {
    var amount_sign = (this.state.amount_sign == '-') ? '+' : '-';
    this.setState({amount_sign: amount_sign});
  },
  valid: function() {
    return (this.state.title
         && this.state.date
         && this.state.amount
         && this.state.amount_sign
         && this.state.payer
         && this.state.user_ids
         && this.state.user_ids.length > 0);
  },
  handleSubmit: function(e) {
    e.preventDefault();
    switch (this.props.type) {
      case 'new':
        this.createRecord();
        break;
      case 'edit':
        this.editRecord();
        break;
    }
  },
  createRecord: function() {
    var record = {
      title: this.state.title,
      date: this.state.date,
      amount: this.state.amount_sign+this.state.amount,
      payer_id: this.state.payer,
      user_ids: this.state.user_ids,
      group_id: this.props.group_id
    };
    $.post('/records', { record: record }, (function(data) {
      this.props.handleNewRecord(data);
      this.setState(this.getInitialState());
      $(React.findDOMNode(this)).find('.select-picker').selectpicker('val','');
      this.hideModal();
    }).bind(this), 'JSON');
  },
  editRecord: function() {
    var record = {
      title: this.state.title,
      date: this.state.date,
      amount: this.state.amount_sign+this.state.amount,
      payer_id: this.state.payer,
      user_ids: this.state.user_ids
    };
    $.ajax({
      method: 'PUT',
      url: "/records/"+this.props.record.id,
      dataType: 'JSON',
      data: {record: record},
      success: (function(data) {
        this.props.handleEditRecord(data, this.props.record);
        this.hideModal();
      }).bind(this)
    });
  },
  hideModal: function() {
    $('#'+this.props.dom_id).modal('hide');
  }
});
