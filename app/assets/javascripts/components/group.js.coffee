@Group = React.createClass
  getInitialState: ->
    page: @props.page
    records: @props.records
    total_pages: @props.total_pages
  getDefaultProps: ->
    group: {}
    page: 1
    records: []
    users: []
    total_pages: 1
  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.div
        className: 'row'
        React.DOM.h2
          className: 'title'
          @props.group.name
        React.DOM.a
          className: 'btn btn-primary pull-right'
          href: '#newRecordModal'
          role: 'button'
          'data-toggle': 'modal'
          I18n.t('components.group.new_record')
      React.createElement RecordModal, type: 'new', dom_id: 'newRecordModal', group_id: @props.group.id, users: @props.users, handleNewRecord: @createRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th
              className: 'col-md-2'
              I18n.t('components.date')
            React.DOM.th
              className: 'col-md-3'
              I18n.t('components.title')
            React.DOM.th
              className: 'col-md-1'
              I18n.t('components.amount')
            React.DOM.th
              className: 'col-md-2'
              I18n.t('components.payed_by')
            React.DOM.th
              className: 'col-md-2'
              I18n.t('components.payed_for')
            React.DOM.th
              className: 'col-md-2'
              I18n.t('components.actions')
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record, handleEditRecord: @updateRecord, handleDeleteRecord: @destroyRecord
      for record in @state.records
        React.createElement RecordModal, key: record.id, type: 'edit', dom_id: "editRecordModal#{record.id}", record: record, users: @props.users, handleEditRecord: @updateRecord
      React.createElement ReactPaginate, max: @state.total_pages, maxVisible: @state.total_pages, onChange: @reloadRecords
  createRecord: (record) ->
    @reloadRecords()
  updateRecord: (new_record, old_record) ->
    @reloadRecords()
  destroyRecord: (record) ->
    @reloadRecords()
  reloadRecords: (page) ->
    if page == undefined
      page = @state.page
    path = '/groups/'+@props.group.id
    $.get path, { page: page }, (data) =>
      records = React.addons.update @state.records, {$set: data.records}
      @setState page: page, records: records, total_pages: data.total_pages
    , 'JSON'
