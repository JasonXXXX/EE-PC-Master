<template>
  <div class="wrap">
    <img class="wrap-img" :src="item.friend_headimg">
    <span class="wrap-span">{{item.friend_name}}</span>
  </div>
</template>

<style scoped>
  .wrap {
    display: flex;
    align-items: center;
    padding: 8px;
    margin: 0;
    background-color: #FFFFFF;
    border-bottom: .5px solid #BBBBBB;
    transition: all .8s ease;
  }

  .wrap:hover {
    background-color: #EFEFEF;
    color: #424242;
    border-color: #EFEFEF;
  }

  .wrap-img {
    display: inline-block;
    height: 24px;
    width: 24px;
    margin: 0 8px;
  }

  .wrap-span {
    display: inline-block;
    text-overflow: ellipsis;
    width: auto;
    max-width: 56px;
    color: #929292;
    font-size: 14px;
  }
</style>

<script>
export default {
  name: 'FriendItem',
  props: ['item'],
  methods: {
    
  }
}
</script>
