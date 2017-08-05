import Vue from 'vue'
import Router from 'vue-router'

import App from '@/App'
import Fake from '~/fake/Fake'

Vue.use(Router)

export default new Router({
  //定义路由列表
  mode: 'history',
  routes: [
    {
      path: '/',
      component: App,
      children: [
        {
          path: '',
          name: 'Fake',
          component: Fake
        },
        {
          path: 'home',
          component: resolve => require(['~/home/Home'], resolve),
          children: [
            {
              path: '',
              component: resolve => require(['~/forum/Forum'], resolve),
              children: [
                {
                  path: '',
                  component: resolve => require(['~/forum/ForumNews'], resolve)
                }
              ]
            },
            {
              path: 'forum',
              component: resolve => require(['~/forum/Forum'], resolve),
              children: [
                {
                  path: '',
                  component: resolve => require(['~/forum/ForumNews'], resolve)
                },
                {
                  path: 'forumnews',
                  component: resolve => require(['~/forum/ForumNews'], resolve)
                },
                {
                  path: 'forumdiscover',
                  component: resolve => require(['~/forum/ForumDiscover'], resolve)
                }
              ]
            },
            {
              path: 'news',
              name: 'News',
              component: resolve => require(['~/forum/NewsDetail'], resolve)
            },
            {
              path: 'discover',
              name: 'Discover',
              component: resolve => require(['~/forum/DiscoverDetail'], resolve)
            },
          ]
        },
      ]
    },

    {
      path: '*',
      name: 'PageNotFound',
      component: resolve => require(['~/common/PageNotFound'], resolve)
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      const position = {};
      if (to.hash) {
        position.selector = to.hash;
      }
      if (to.matched.some(m => m.meta.scrollTop)) {
        position.x = 0;
        position.y = 0;
      }
      return position;
    }
  }
})
