var GroupsListView = Backbone.View.extend({

    el: '#groups',

    initialize: function (options) {
        var _this = this;

        options = options || {};
        _this.userModel = options.userModel;
        _this.render();
    },

    render: function () {
        var _this = this;
        // Sample Group Data
        _this.renderSampleGroups();

        // To Render User Group Data
        //__this.renderUserGroups();
    },

    events: {
    },

    renderSampleGroups: function(){
        var _this = this;
        // Sample Data
        var sample_data = JSON.stringify([
            {name: 'Group to protect Wild Life in Missouri Parks', description: 'We must protect nature!'},
            {name: 'WashU CompSci', description: '010101000101010101010101000010101'},
            {name: 'CiviWiki Dev Team', description: 'We love working on civiwiki!'},
            {name: 'We Complain About Everything', description: 'We hate everything!'}
        ]);
        var group_data = JSON.parse(sample_data);

        // Collection Wrapper
        _this.$el.empty().append('<ul class="collection collection_groups"></ul>');

        // Add Elements to the collection
        _.each(group_data, function(group){
            var item_img = '<img class="circle" src="/static/img/team_profile/team_default.png">'
            var item_title = '<span class="title">' + group.name + '</span>';
            var item_content = '<p class="light grey-text">' + group.description + '</p>'
            var item_icon = '<a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>';

            $('.collection_groups').append('<li class="collection-item avatar">'+item_img + item_title + item_content +'</li>');
        });
    },

    renderUserGroups: function(){
        var _this = this;
        // TODO: Finish up render function once backend is set
        // Get Data from User
        // Ajax request
        // For each group retrieved appened collection
    }
});
