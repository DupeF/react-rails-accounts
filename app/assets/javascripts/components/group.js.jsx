var Group = React.createClass({
  getInitialState: function() {
    return {
      page: this.props.page,
      records: this.props.records,
      total_pages: this.props.total_pages
    };
  },
  getDefaultProps: function() {
    return {
      group: {},
      page: 1,
      records: [],
      users: [],
      total_pages: 1
    };
  },
  render: function() {
    return (
      <div className = 'records'>
        <div className = 'row'>
          <h2 className = 'title'>{this.props.group.name}</h2>
          <a className = 'btn btn-primary pull-right'
             href = '#newRecordModal'
             role = 'button'
             data-toggle = 'modal'>{I18n.t('components.group.new_record')}</a>
        </div>
        <RecordModal type = 'new'
                     dom_id = 'newRecordModal'
                     group_id = {this.props.group.id}
                     users = {this.props.users}
                     handleNewRecord = {this.createRecord}/>
        <hr/>
        <table className = 'table table-bordered'>
          <thead>
            <tr>
              <th className = 'col-md-2'>{I18n.t('components.date')}</th>
              <th className = 'col-md-3'>{I18n.t('components.title')}</th>
              <th className = 'col-md-1'>{I18n.t('components.amount')}</th>
              <th className = 'col-md-2'>{I18n.t('components.payed_by')}</th>
              <th className = 'col-md-2'>{I18n.t('components.payed_for')}</th>
              <th className = 'col-md-2'>{I18n.t('components.actions')}</th>
            </tr>
          </thead>
          <tbody>
            {this.state.records.map((function(record) {
              return <Record key = {record.id}
                             record = {record}
                             handleEditRecord = {this.updateRecord}
                             handleDeleteRecord = {this.destroyRecord}/>;
            }).bind(this))}
          </tbody>
        </table>
        {this.state.records.map((function(record) {
          return <RecordModal key = {record.id}
                              type = 'edit'
                              dom_id = {'editRecordModal'+record.id}
                              record = {record}
                              users = {this.props.users}
                              handleEditRecord = {this.updateRecord}/>;
        }).bind(this))}
        <ReactPaginate max = {this.state.total_pages}
                       maxVisible = {this.state.total_pages}
                       onChange = {this.reloadRecords}/>
      </div>
    );
  },
  createRecord: function(record) {
    this.reloadRecords();
  },
  updateRecord: function(new_record, old_record) {
    this.reloadRecords();
  },
  destroyRecord: function(record) {
    this.reloadRecords();
  },
  reloadRecords: function(page) {
    if (page == undefined) { page = this.state.page; }
    var path = '/groups/'+this.props.group.id;
    $.get(path, {page: page}, (function(data) {
      var records = React.addons.update(this.state.records, {$set: data.records});
      this.setState({page: page, records: records, total_pages: data.total_pages});
    }).bind(this), 'JSON');
  }
});
