<template>
  <v-app>
    <v-navigation-drawer class="pb-0" app dark v-model="drawer" temporary fixed right v-if="isAuthenticated">
      <v-layout fill-height wrap align-content-space-between>
        <v-flex>
          <v-list class="pa-1">
            <v-list-tile avatar>
              <v-list-tile-avatar>
                <v-icon>face</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-content>
                <v-list-tile-title>{{ currentUser.name }}</v-list-tile-title>
              </v-list-tile-content>
              <v-list-tile-action>
                <v-btn icon @click.native.stop="drawer = !drawer">
                  <v-icon>close</v-icon>
                </v-btn>
              </v-list-tile-action>
            </v-list-tile>
          </v-list>
          <v-divider light></v-divider>
          <v-list class="py-0">
            <v-list-tile :to="{ name: 'Home' }">
              <v-list-tile-action>
                <v-icon>home</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>메인화면</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            <v-list-tile :to="{ name: 'Problems' }">
              <v-list-tile-action>
                <v-icon>clear_all</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>문제모음</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-flex>
        <v-flex>
          <v-list>
            <!-- <v-list-tile v-if="isAdmin" :to="{ name: 'AdminHome' }">
              <v-list-tile-action>
                <v-icon>dashboard</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>어드민</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile> -->
            <v-list-tile v-if="isAuthenticated" @click="logout">
              <v-list-tile-action>
                <v-icon>clear</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>로그아웃</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-flex>
      </v-layout>
    </v-navigation-drawer>
    <v-navigation-drawer app v-model="drawer" temporary fixed right v-else="">
      <v-tabs v-model="activeTab" grow>
        <v-tab :value="0" :key="0">로그인</v-tab>
        <v-tab :value="1" :key="1">회원가입</v-tab>
        <v-tab-item :value="0" :key="0"><sign-in></sign-in></v-tab-item>
        <v-tab-item :value="1" :key="1"><sign-up></sign-up></v-tab-item>
      </v-tabs>
    </v-navigation-drawer>
    <v-toolbar app class="pl-3 pr-3">
      <v-btn icon :to="{ name: 'Home' }">
        <v-icon>home</v-icon>
      </v-btn>
      <v-toolbar-title class="mr-3">OMRice</v-toolbar-title>
      <v-toolbar-items>
        <v-btn flat :to="{ name: 'Problems' }">Problems</v-btn>
      </v-toolbar-items>
      <v-spacer></v-spacer>
      <v-text-field
        prepend-icon="search"
        label="문제 검색..."
        class="mx-3"
        solo
        flat></v-text-field>
      <v-toolbar-side-icon @click="drawer = !drawer" v-if="isAuthenticated"></v-toolbar-side-icon>
      <v-btn color="info" @click="drawer = !drawer" v-else="">시작하기</v-btn>
    </v-toolbar>
    <v-content>
      <v-container fluid>
        <transition name="fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </v-container>
    </v-content>
    <v-footer dark height="auto" class="grey darken-3">
      <v-layout row wrap justify-center>
        <v-flex xs12 py-3 text-xs-center white--text>
          &copy;2018 — <strong>{{ new Date().getFullYear() }}</strong>
        </v-flex>
      </v-layout>
    </v-footer>
  </v-app>
</template>
<script>
import { mapGetters } from 'vuex'
import SignIn from '../users/SignIn.vue'
import SignUp from '../users/SignUp.vue'
export default {
  name: 'Main',
  components: {
    SignIn, SignUp
  },
  data: () => ({
    drawer: false,
    activeTab: 0
  }),
  computed: {
    ...mapGetters(['isAuthenticated', 'currentUser', 'isAdmin'])
  },
  methods: {
    logout () {
      this.$store.dispatch('AUTH_LOGOUT')
    }
  },
  created() {
    if (this.isAuthenticated) this.$store.dispatch('USER_REQUEST')
  }
}
</script>
<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity .25s }
.fade-enter, .fade-leave-to { opacity: 0 }
</style>
