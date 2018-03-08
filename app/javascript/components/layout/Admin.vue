<template>
  <v-app dark>
    <v-navigation-drawer app dark value permanent :mini-variant="mini">
      <v-list>
        <v-list-tile href="#" @click.prevent="mini = !mini">
          <v-list-tile-action>
            <v-icon>{{ mini ? 'menu' : 'chevron_left' }}</v-icon>
          </v-list-tile-action>
          <v-list-tile-content><v-list-tile-title>접기</v-list-tile-title></v-list-tile-content>
        </v-list-tile>
      </v-list>
      <v-list class="pt-0">

        <v-list-tile :to="{ name: 'AdminProblemSources' }">
          <v-list-tile-action>
            <v-icon>dashboard</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>기출문제모음</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile :to="{ name: 'AdminProblems' }">
          <v-list-tile-action>
            <v-icon>clear_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>문제모음</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile></v-list-tile>
        <v-list-tile></v-list-tile>
        <v-list-tile></v-list-tile>

        <v-list-tile v-show="!mini" @click="logout">
          <v-list-tile-action>
            <v-icon>clear</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>로그아웃</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar app>
      <v-toolbar-title class="mr-3">OMRice ADMIN</v-toolbar-title>
      <!-- <v-toolbar-items>
        <v-btn flat :to="{ name: 'AdminProblems' }">Problems</v-btn>
      </v-toolbar-items> -->
      <v-spacer></v-spacer>
      <v-text-field
        prepend-icon="search"
        label="문제 검색..."
        class="mx-3"
        solo
        flat></v-text-field>
    </v-toolbar>
    <v-content>
      <v-container fluid>
        <transition name="fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </v-container>
    </v-content>
    <v-footer app dark height="auto" class="grey darken-3">
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
export default {
  name: 'Main',
  data: () => ({
    mini: true
  }),
  computed: {
    ...mapGetters(['isAuthenticated', 'currentUser', 'isAdmin'])
  },
  methods: {
    logout () {
      this.$store.dispatch('AUTH_LOGOUT')
    }
  }
}
</script>
<style lang="scss" scoped>
.fade-enter-active, .fade-leave-active { transition: opacity .25s }
.fade-enter, .fade-leave-to { opacity: 0 }
</style>
