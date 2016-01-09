var PersonalRecordForm = React.createClass({
  getInitialState: function() {
    return {
      title: '',
      date: '',
      amount_sign: '-',
      amount: ''
    };
  },
  render: function() {
    return (
      <form className = 'form-inline record-form'
            onSubmit = {this.handleSubmit}>
        <div className = 'form-group'>
          <input type = 'text'
                 id = 'pers-rec-form-date'
                 className = 'form-control'
                 data-provide = 'datepicker'
                 placeholder = {I18n.t('components.date')}
                 name = 'date'
                 value = {this.state.date}
                 onChange = {this.handleChange} />
        </div>
        <div className = 'form-group'>
          <input type = 'text'
                 className = 'form-control'
                 placeholder = {I18n.t('components.title')}
                 name = 'title'
                 value = {this.state.title}
                 onChange = {this.handleChange} />
        </div>
        <div className = 'form-group'>
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
        <button className = 'btn btn-primary'
                type = 'submit'
                disabled = {!this.valid()}>
          {I18n.t('components.record_form.create')}
        </button>
      </form>
    );
  },
  componentDidMount: function() {
    $('#pers-rec-form-date').on("changeDate", (function(e) {
      this.handleChange(e);
    }).bind(this));
  },
  handleChange: function(e) {
    var stateArgs = {};
    stateArgs[e.target.name] = e.target.value;
    this.setState(stateArgs);
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
    return (this.state.title && this.state.date && this.state.amount && this.state.amount_sign);
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var personal_record = {
      title: this.state.title,
      date: this.state.date,
      amount: this.state.amount_sign+this.state.amount,
      personal_balance_id: this.props.balance_id
    };
    $.post('/personal_records', { personal_record: personal_record }, (function(data) {
      this.props.handleNewRecord(data);
      this.setState(this.getInitialState());
    }).bind(this), 'JSON');
  }
});
