Package.describe({
    summary: "A pattern to display application errors to the user"
});

Package.on_use(function (api, where) {
    api.use(['minimongo', 'mongo-livedata', 'templating', 'jade', 'coffeescript'], 'client');

    api.export('Errors');
    api.add_files(['errors.coffee', 'errors_list.jade', 'errors_list.coffee'], 'client');
});

Package.on_test(function(api){
    api.use('errors', 'client');
    api.use(['tinytest', 'test-helpers', 'coffeescript'], 'client');

    api.add_files('errors_tests.coffee', 'client')
})