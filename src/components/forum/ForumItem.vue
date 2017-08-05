<template>
  <div class="wrap">
    <div class="wrap-summary">
      <p class="wrap-summary-title" @click="routerToDetail">{{item.title}}</p>
      <p class="wrap-summary-detail">
        <i class="el-icon-star-on wrap-summary-detail-star_count"></i>
        <span class="wrap-summary-detail-star_count">{{item.message_like}}</span>
        <span class="wrap-summary-detail-author_time">{{item.sender_name}}</span>
        <span class="wrap-summary-detail-author_time">{{item.send_time}}</span>
      </p>
    </div>
  </div>
</template>

<style scoped>
  .wrap {
    display: flex;
    margin: 0;
    padding: 12px;
    border-bottom: .5px solid #BDBDBD;
  }

  .wrap-summary {
    flex: 1;
    margin: 0;
    padding: 8px;
    text-align: left;
  }

  .wrap-summary-title {
    margin: 8px;
    font-size: 23px;
    color: #424242;
  }

  .wrap-summary-detail {
    margin: 0 8px 8px 8px;
    font-size: 14px;
  }

  .wrap-summary-detail-star_count {
    color: #0873F9;
  }

  .wrap-summary-detail-author_time {
    display: inline-block;
    padding: 0 4px;
    color: #939393;
  }
</style>

<script>
export default {
  name: 'ForumItem',
  props: ['item'],
  methods: {
    routerToDetail () {
      this.$router.push('/home/' + (this.item.mark==1? 'news': 'discover'))
    }
  }
}
</script>
