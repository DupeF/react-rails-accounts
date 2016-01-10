var PersonalBalance = React.createClass({
  getInitialState: function() {
    return {
      page: this.props.page,
      records: this.props.records,
      total_pages: this.props.total_pages,
      total_credits: this.props.total_credits,
      total_debits: this.props.total_debits
    };
  },
  getDefaultProps: function() {
    return {
      balance: {},
      page: 1,
      records: [],
      total_pages: 1,
      total_credits: 0,
      total_debits: 0
    };
  },
  render: function() {
    return (
      <div className = 'records'>
        <h2 className = 'title'>
          {this.props.balance.name}
        </h2>
        <div className = 'row'>
          <AmountBox type = 'success'
                     page_amount = {this.page_credits()}
                     total_amount = {this.state.total_credits}
                     text = {I18n.t('components.amount_box.credit')}/>
          <AmountBox type = 'danger'
                     page_amount = {this.page_debits()}
                     total_amount = {this.state.total_debits}
                     text = {I18n.t('components.amount_box.debit')}/>
          <AmountBox type = 'info'
                     page_amount = {this.page_balance()}
                     total_amount = {this.total_balance()}
                     text = {I18n.t('components.amount_box.balance')}/>
        </div>
        <PersonalRecordForm balance_id = {this.props.balance.id}
                            handleNewRecord = {this.createRecord}/>
        <hr/>
        <table className = 'table table-bordered'>
          <thead>
            <tr>
              <th className = 'col-md-3'>{I18n.t('components.date')}</th>
              <th className = 'col-md-3'>{I18n.t('components.title')}</th>
              <th className = 'col-md-3'>{I18n.t('components.amount')}</th>
              <th className = 'col-md-3'>{I18n.t('components.actions')}</th>
            </tr>
          </thead>
          <tbody>
            {this.state.records.map((function(record) {
              return <PersonalRecord key = {record.id}
                                     record = {record}
                                     handleEditRecord = {this.updateRecord}
                                     handleDeleteRecord = {this.destroyRecord}/>;
            }).bind(this))}
          </tbody>
        </table>
        <ReactPaginate max = {this.state.total_pages}
                       maxVisible = {this.state.total_pages}
                       onChange = {this.reloadRecords}/>
      </div>
    );
  },
  page_credits: function() {
    var credits = this.state.records.filter(function(val) { return (val.amount >= 0) });
    return credits.reduce((function(prev, curr) { return (prev + parseFloat(curr.amount)); }), 0);
  },
  page_debits: function() {
    var debits = this.state.records.filter(function(val) { return (val.amount < 0) });
    return debits.reduce((function(prev, curr) { return (prev + parseFloat(curr.amount)); }), 0);
  },
  page_balance: function() {
    return (this.page_debits() + this.page_credits());
  },
  total_balance: function() {
    return (this.state.total_credits + this.state.total_debits);
  },
  createRecord: function(record) {
    this.addToTotals(record.amount);
    this.reloadRecords();
  },
  updateRecord: function(new_record, old_record) {
    this.removeFromTotals(old_record.amount);
    this.addToTotals(new_record.amount);
    this.reloadRecords();
  },
  destroyRecord: function(record) {
    this.removeFromTotals(record.amount);
    this.reloadRecords();
  },
  reloadRecords: function(page) {
    if (page == undefined) {
      page = this.state.page;
    }
    var path = '/personal_balances/'+this.props.balance.id;
    $.get(path, {page: page}, (function(data) {
      var records = React.addons.update(this.state.records, {$set: data.records});
      this.setState({page: page, records: records, total_pages: data.total_pages});
    }).bind(this), 'JSON');
  },
  addToTotals: function(amount) {
    if (amount >= 0) {
      this.setState({total_credits: (this.state.total_credits+amount)});
    } else {
      this.setState({total_debits: (this.state.total_debits+amount)});
    }
  },
  removeFromTotals: function(amount) {
    if (amount >= 0) {
      this.setState({total_credits: (this.state.total_credits-amount)});
    } else {
      this.setState({total_debits: (this.state.total_debits-amount)});
    }
  }
});
