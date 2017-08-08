<template>
  <div class="wrap">
    <teacher-item v-for="item in items" :item="item" :key="item.id"></teacher-item>
  </div>
</template>

<style scoped>
  .wrap {
    display: flex;
  }
</style>

<script>
import TeacherItem from './TeacherItem'

export default {
  name: 'TeacherRol',
  props: ['items'],
  components: {
    TeacherItem
  },
  created () {
  }
}
</script>
