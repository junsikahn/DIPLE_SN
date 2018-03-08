<template>
  <v-card flat>
    <v-container>
      <h1>로그인</h1>
      <p>학번과 비밀번호를 입력해주세요</p>
      <v-card class="pt-2 pb-2 pr-3 pl-3">
        <v-text-field type="number"
                      label="학번"
                      required
                      clearable
                      prepend-icon="fingerprint"
                      v-model="user.uid"
                      hint="숫자로 입력해주세요 ex) 01088627156"
                      :rules="[rules.required]"
                      :error-messages="errors.uid"></v-text-field>
        <v-text-field type="password"
                      label="비밀번호"
                      required
                      clearable
                      prepend-icon="lock"
                      v-model="user.password"
                      min="8"
                      max="20"
                      :counter="20"
                      hint="비밀번호는 6자리 이상 입력해주세요"
                      :rules="[rules.required, rules.password]"
                      :error-messages="errors.password"></v-text-field>
      </v-card>
      <v-btn block @click.stop="login">로그인</v-btn>
    </v-container>
  </v-card>
</template>
<script>
import { mapGetters } from 'vuex'
export default {
  name: 'SignIn',
  data: () => ({
    user: {
      uid: null,
      password: null
    },
    errors: {},
    rules: {
      required: (value) => !!value || '필수입력값입니다',
      password: (value) => value && value.length >= 6 && value.length <= 20 || '비밀번호는 6자 이상 20자 이하로 입력해주세요'
    }
  }),
  methods: {
    login() {
      this.$store.dispatch('AUTH_REQUEST', { url: 'sign_in', user: this.user })
        .then(res => this.loginSuccess(res))
        .catch(err => this.loginFailed(err))
    },
    loginSuccess (res) { this.$router.replace(this.$route.query.redirect || '/') },
    loginFailed (err) { this.errors = err.response.data.errors }
  }
}
</script>
<style lang="scss" scoped>
</style>
