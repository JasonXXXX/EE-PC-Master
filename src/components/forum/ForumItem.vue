<template>
  <transition name="el-zoom-in-top">
    <div class="wrap">
      <div class="wrap-summary">
        <p class="wrap-summary-title" @click="routerToDetail">{{item.title}}</p>
        <p class="wrap-summary-detail">
          <i class="el-icon-star-on wrap-summary-detail-star_count" v-if="item.mark==forumState"></i>
          <span class="wrap-summary-detail-star_count" v-if="item.mark==forumState">{{item.message_like}}</span>
          <icon class="wrap-summary-detail-star_count" v-if="item.mark==forumState" name="commenting"></icon>
          <span class="wrap-summary-detail-star_count" v-if="item.mark==forumState">{{item.message_mark}}</span>
          <span class="wrap-summary-detail-author_time">{{item.sender_name}}</span>
          <span class="wrap-summary-detail-author_time">{{item.send_time}}</span>
        </p>
      </div>
    </div>
  </transition>
</template>

<style scoped>
  .wrap {
    display: flex;
    margin: 0;
    padding: 12px;
    border-bottom: .5px solid #BDBDBD;
    transition: all .6s ease;
  }

  .wrap:hover {
    box-shadow: 1px 1px 8px #BBBBBB;
    border-bottom: .5px solid transparent;
  }

  .wrap-summary {
    flex: 1;
    margin: 0;
    padding: 0 8px;
    text-align: left;
  }

  .wrap-summary-title {
    margin: 8px;
    font-size: 20px;
    color: #424242;
  }

  .wrap-summary-detail {
    display: flex;
    align-items: center;
    margin: 0 8px;
    font-size: 12px;
  }

  .wrap-summary-detail-star_count {
    margin: 0 4px 0 0;
    color: #2070FF;
  }

  .wrap-summary-detail-author_time {
    display: inline-block;
    padding: 0 4px;
    color: #939393;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import 'vue-awesome/icons/commenting'
import types from '@/store/types'

export default {
  name: 'ForumItem',
  props: ['item'],
  methods: {
    routerToDetail () {
      this.$store.commit(types.UPDATE_FORUM_MESSAGEID, this.item.message_id)
      this.$router.push('/' + (this.item.message_mark == 1 ? 'news' : 'discover'))
    }
  },
  computed: {
    ...mapGetters([
      'forumState',
    ]),
    getForums () {
      return this.forums.filter(item => item.mark === this.forumState)
    }
  }
}
</script>
