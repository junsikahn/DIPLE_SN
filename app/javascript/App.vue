<template>
  <transition name="fade" mode="out-in">
    <router-view></router-view>
  </transition>
</template>
<script>
export default {
  name: 'App'
}
</script>
<style lang="scss" scoped>
.fade-enter-active, .fade-leave-active { transition: opacity .25s }
.fade-enter, .fade-leave-to { opacity: 0 }
</style>
