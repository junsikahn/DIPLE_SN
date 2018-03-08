<template>
  <main>
    <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
      <div class="container">
        <router-link class="navbar-brand" :to="{ name: 'App' }">OMRice</router-link>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <router-link class="nav-link" :to="{ name: 'Problems' }">ProblemList</router-link>
          </ul>
          <ul class="navbar-nav">
            <li class="nav-item" v-if="isAdmin">
              <router-link class="nav-link" :to="{ name: 'Admin' }">어드민</router-link>
            </li>
            <li class="nav-item" v-if="isAuthenticated">
              <a class="nav-link" @click.prevent="logout" href="#">{{ currentUser.name }} 로그아웃</a>
            </li>
            <li class="nav-item" v-else>
              <router-link class="nav-link" :to="{ name: 'SignIn' }">시작하기</router-link>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <section class="container-fluid pt-3 pb-5">
      <div class="container">
        <router-view></router-view>
      </div>
    </section>
  </main>
</template>
<script>
import { mapGetters } from 'vuex'
export default {
  name: 'Main',
  data: () => ({
  }),
  computed: {
    ...mapGetters(['isAuthenticated', 'currentUser', 'isAdmin'])
  },
  methods: {
    logout () {
      this.$store.dispatch('AUTH_LOGOUT')
        .then(() => { this.$router.replace(this.$route.query.redirect || '/sign_in') })
    }
  },
  created() {
    if (this.isAuthenticated) this.$store.dispatch('USER_REQUEST')
  }
}
</script>
<style scoped>
</style>
