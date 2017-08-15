import Vue from 'vue'
import Router from 'vue-router'

import store from '@/store'

import App from '@/App'
import Home from '~/home/Home'

Vue.use(Router)

const router = new Router({
  //定义路由列表
  mode: 'history',
  routes: [
    {
      path: '/login',
      name: 'Login',
      component: resolve => require(['~/login/Login'], resolve)
    },
    {
      path: '/register',
      name: 'Register',
      component: resolve => require(['~/login/Register'], resolve)
    },
    {
      path: '/',
      component: Home,
      children: [
        {
          path: 'forum',
          name: 'Forum',
          component: resolve => require(['~/forum/Forum'], resolve)
        },
        {
          path: 'teacher',
          name: 'Teacher',
          component: resolve => require(['~/teacher/Teacher'], resolve)
        },
        {
          path: 'course',
          name: 'Course',
          component: resolve => require(['~/cbroom/Course'], resolve)
        },
        {
          path: 'coursedetail',
          name: 'CourseDetail',
          component: resolve => require(['~/course/CourseDetail'], resolve)
        },
        {
          path: 'Setting',
          name: 'Setting',
          component: resolve => require(['~/setting/Setting'], resolve)
        },
        {
          path: 'videoupload',
          name: 'VideoUpload',
          component: resolve => require(['~/course/VideoUpload'], resolve)
        },
        {
          path: 'me',
          component: resolve => require(['~/me/Me'], resolve),
          children: [
            {
              path: 'courseing',
              component: resolve => require(['~/course/CourseLearning'], resolve)
            },
            {
              path: 'coursedone',
              component: resolve => require(['~/course/CourseLearned'], resolve)
            },
            {
              path: 'homework',
              component: resolve => require(['~/homework/Homeworking'], resolve)
            },
            {
              path: 'homeworking',
              component: resolve => require(['~/homework/Homeworking'], resolve)
            },
            {
              path: 'homeworkdone',
              component: resolve => require(['~/homework/Homeworked'], resolve)
            },
            {
              path: 'note',
              component: resolve => require(['~/note/Note'], resolve)
            },
            {
              path: 'plan',
              component: resolve => require(['~/plan/Plan'], resolve)
            },
            {
              path: '',
              component: resolve => require(['~/course/CourseLearning'], resolve)
            },
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
        {
          path: 'detail',
          name: 'UserDetail',
          component: resolve => require(['~/user/UserDetail'], resolve)
        },
        {
          path: 'friend',
          name: 'Friend',
          component: resolve => require(['~/friend/Friend'], resolve)
        },
        {
          path: '',
          name: 'Default',
          component: resolve => require(['~/forum/Forum'], resolve)
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

router.beforeEach((to, from, next) => {
  if (store.getters.user.userid === 0 && to.path !== '/login') {
    next('/login')
  } else {
    next()
  }
})

export default router
