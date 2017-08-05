<template>
  <transition name="el-fade-in">
    <div class="fake">
      <h1 class="fake-welcome">Welcome to E.E.</h1>
    </div>
  </transition>
</template>

<style scoped>
  .fake {
    display: flex;
    align-items: center;
    height: 100vh;
    width: 100%;
    text-align: center;
  }

  .fake-welcome {
    margin: 0 auto;
    color: #0873F9;
  }
</style>

<script>
export default {
  name: 'Fake',
  mounted () {
    setTimeout(() => {
      this.$router.replace('/home')
    }, 1000);
  }
}
</script>
