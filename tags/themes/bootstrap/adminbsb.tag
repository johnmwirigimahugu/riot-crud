<layout>
    <section class="content">
        <div id="content" class="container-fluid">
            <div class="block-header">
            </div>
        </div>
    </section>
</layout>


<top-menu>

    <link href="/bower_components/gentelella/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="/bower_components/gentelella/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="/bower_components/gentelella/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">

    <script>
        var self = this;
        self.dependencies = [
            '/bower_components/gentelella/vendors/pnotify/dist/pnotify.js',
            '/bower_components/gentelella/vendors/pnotify/dist/pnotify.nonblock.js',
            // '/bower_components/gentelella/vendors/pnotify/dist/pnotify.buttons.js',
        ];

        self.mixin('FeatherClientMixin');

        RiotControl.on('notification', (title, type, text) => {
            this.notify(title, type, text);
        });

        self.on('before-mount', () => {

            self.loadDependencies();

            var services = Object.keys(self.opts.services);
            for(key in services) {

                var service = services[key];
                var events = self.opts.services[service];
                for(event in events) {
                    var event = events[event];
                    self.event(service, event, function(service, event,response){
                        var eventTypeMap = {'created':'info', 'updated':'info','removed':'success'};
                        self.notify(
                            'Service "' + service + '" has been <i>' + event + '</i>'
                            , eventTypeMap[event] || event
                            ,'id: ' + (response.id || response._id)
                        );
                    })
                }
            }
        })

        this.event = function(service, event, cb) {
            self[service] = self.client.service(service);
            self[service].on(event,function(response){
                cb(service, event, response);
            })
        }

        this.notify = function(title, type, text) {
            var stack_topleft = {"dir1": "down", "dir2": "right", "push": "top"};
            var stack_bottomleft = {"dir1": "right", "dir2": "up", "push": "top"};
            var stack_custom = {"dir1": "right", "dir2": "down"};
            var stack_custom2 = {"dir1": "left", "dir2": "up", "push": "top"};
            var stack_modal = {"dir1": "down", "dir2": "right", "push": "top", "modal": true, "overlay_close": true};
            var stack_bar_top = {"dir1": "down", "dir2": "right", "push": "top", "spacing1": 0, "spacing2": 0};
            var stack_bar_bottom = {"dir1": "up", "dir2": "right", "spacing1": 0, "spacing2": 0};
            /*********** Positioned Stack ***********
            * This stack is initially positioned through code instead of CSS.
            * This is done through two extra variables. firstpos1 and firstpos2
            * are pixel values, relative to a viewport edge. dir1 and dir2,
            * respectively, determine which edge. It is calculated as follows:
            *
            * - dir = "up" - firstpos is relative to the bottom of viewport.
            * - dir = "down" - firstpos is relative to the top of viewport.
            * - dir = "right" - firstpos is relative to the left of viewport.
            * - dir = "left" - firstpos is relative to the right of viewport.
            */
            var stack_bottomright = {"dir1": "up", "dir2": "left", "firstpos1": 25, "firstpos2": 25};
            if(typeof PNotify == 'function')
            new PNotify({
                  delay: 3000,
                  title: title,
                  // type: type,
                  text: text || '',
                  // nonblock: {
                  //     nonblock: true
                  // },
                  // styling: 'bootstrap3',
                  newest_on_top: true,
                  addclass: 'stack-bottomright bg-' + ($('body').attr('class').replace('theme-','') || 'red'),
                  stack: stack_bottomright
            });
        }


    </script>

</top-menu>

<side-menu>
    <li class="header">RIOT+FEATHERS CRUD DEMO</li>
    <!-- default routes -->
    <li each={route, key in opts.routes.default.routes}>
        <a href="#{ route.route }" onclick="{ routeTo }" style="" view="#{ route.route }">
            <i class="material-icons">{route.icon}</i>
            <span>{ route.title }</span>
        </a>
    </li>
    <!-- end default routes -->

    <!-- custom routes RiotControl.addMenuGroup() -->
    <li each={group, key in opts.routes} if={key!='default'}>
        <a if={group.title} href="javascript:void(0);" class="menu-toggle">
            <i class="material-icons">{group.icon}</i>
            <span>{group.title}</span>
        </a>
        <ul class="ml-menu">
            <li each={route, key in group.routes}>
                 <a href="#{ route.route }" onclick="{ routeTo }" style="" view="#{ route.route }">
                    <i class="material-icons">{route.icon || 'list'}</i>
                    <span>{route.title}</span>
                 </a>
            </li>
        </ul>
    </li>
    <!-- end custom routes RiotControl.addMenuGroup() -->


    <yield/>
    <script>

        RiotControl.on('routeStateChange',(path) => {
            $('.menu').find('a').removeClass('col-cyan');
            $('.menu').find('a[href="' + window.location.hash + '"]').addClass('col-cyan');
        });

        this.on('update', (event) => {

        });

        this.on('mount', () => {
            this.initPlugins();
        });

        this.routeTo = (e) => {
            route(e.item.route.route || e.item.route.view);
        }

        this.initPlugins = () => {
            $.AdminBSB.leftSideBar.activate();
        }
    </script>

</side-menu>