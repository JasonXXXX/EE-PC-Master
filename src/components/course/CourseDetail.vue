<template>
  <transition name="fade">
    <div>
      <div class="title">
        <router-link class="router-link" to="/course"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
        <span>{{$route.params.coursetitle}}</span>
      </div>
    </div>
  </transition>
</template>

<style scoped>
</style>

<script>
import router from '@/router/index'

export default {
  name: 'CourseDetail',
  data() {
    return {
    }
  },
  mounted() {

  },
  methods: {

  }
}
</script>
