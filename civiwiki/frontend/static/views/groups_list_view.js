var GroupsListView = Backbone.View.extend({

    el: '#groups',
    groupsTemplate: _.template($('#groups-template').html()),

    initialize: function (options) {
        var _this = this;

        options = options || {};
        _this.userModel = options.userModel;
        _this.render();
    },

    render: function () {
        var _this = this;
        // Sample Group Data

        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON(),
            groups: sampleGroups()
        }));
    },

    events: {
    },

    sampleGroups: function(){
        // Sample Data
        var _this = this;
        var sample_data = JSON.stringify([
            {name: 'Group to protect Wild Life in Missouri Parks', description: 'We must protect nature!'},
            {name: 'WashU CompSci', description: '010101000101010101010101000010101'},
            {name: 'CiviWiki Dev Team', description: 'We love working on civiwiki!'},
            {name: 'We Complain About Everything', description: 'We hate everything!'}
        ]);
        return JSON.parse(sample_data);
    },

    renderUserGroups: function(){
        var _this = this;
        // TODO: Finish up render function once backend is set
        // Get Data from User
        // Ajax request
        // For each group retrieved appened collection
    }
});
