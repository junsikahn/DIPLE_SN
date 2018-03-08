<template>
  <v-card flat>
    <v-container>
      <h1>회원가입</h1>
      <p>학번과 비밀번호를 입력해주세요</p>
      <v-stepper v-model="step" vertical>
        <v-stepper-step step="1" :complete="step > 1" editable>
          기본 정보 입력
          <small>이름, 학번, 비밀번호를 입력해주세요</small>
        </v-stepper-step>
        <v-stepper-content step="1">
          <v-text-field type="text"
                        label="이름"
                        required
                        clearable
                        prepend-icon="account_circle"
                        v-model="user.name"
                        hint="이름을 입력해주세요"
                        :rules="[rules.required]"
                        :error-messages="errors.uid"></v-text-field>
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
          <v-text-field type="password"
                        label="비밀번호 확인"
                        required
                        clearable
                        prepend-icon="spellcheck"
                        v-model="user.password_confirmation"
                        min="8"
                        max="20"
                        :counter="20"
                        hint="비밀번호를 다시 입력해주세요"
                        :rules="[rules.required, rules.password]"
                        :error-messages="errors.password_confirmation"></v-text-field>
        </v-stepper-content>
        <v-stepper-step step="2" :complete="step > 2" editable>
          추가 정보 입력
          <small>성별, 전공, 나이를 알려주세요</small>
        </v-stepper-step>
        <v-stepper-content step="2">
          <v-select label="성별"
                    required
                    clearable
                    prepend-icon="wc"
                    :items="gender_options"
                    v-model="user.gender"
                    hint="성별을 선택해주세요"
                    :rules="[rules.required]"
                    :error-messages="errors.gender"></v-select>
          <v-select label="전공"
                    required
                    clearable
                    prepend-icon="school"
                    :items="liberal_options"
                    v-model="user.liberal"
                    hint="전공을 선택해주세요"
                    :rules="[rules.required]"
                    :error-messages="errors.liberal"></v-select>
          <v-menu ref="menu" lazy v-model="menu" :close-on-content-click="false" transition="scale-transition" offset-y full-width :nudge-right="40" min-width="290px">
            <v-text-field slot="activator" label="생년월일" v-model="user.birthday" prepend-icon="event" readonly></v-text-field>
            <v-date-picker ref="picker" v-model="user.birthday" @change="setDate" min="1990-01-01" :max="new Date().toISOString().substr(0, 10)"></v-date-picker>
          </v-menu>
          <v-checkbox v-model="user.agree_terms" label="동의"></v-checkbox>
        </v-stepper-content>
      </v-stepper>
      <v-btn block @click.stop="signup">회원가입</v-btn>
    </v-container>
  </v-card>
</template>
<script>
import { mapGetters } from 'vuex'
export default {
  name: 'SignUp',
  data: () => ({
    menu: false,
    user: {
      name: null,
      uid: null,
      password: null,
      password_confirmation: null,
      gender: null,
      liberal: null,
      birthday: null,
      agree_terms: false
    },
    errors: {},
    gender_options: [
      { value: 1, text: '남성' },
      { value: 0, text: '여성' },
    ],
    liberal_options: [
      { value: 1, text: '문과' },
      { value: 0, text: '이과' },
    ],
    step: 1,
    rules: {
      required: (value) => !!value || '필수입력값입니다',
      password: (value) => value && value.length >= 6 && value.length <= 20 || '비밀번호는 6자 이상 20자 이하로 입력해주세요'
    }
  }),
  watch: {
    menu(val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },
  methods: {
    setDate(date) {
      this.$refs.menu.save(date)
    },
    signup() {
      this.$store.dispatch('AUTH_REQUEST', { url: 'sign_up', user: this.user })
        .then(res => this.signupSuccess(res))
        .catch(err => this.signupFailed(err))
    },
    signupSuccess (res) { this.$router.replace(this.$route.query.redirect || '/') },
    signupFailed (err) { this.errors = err.response.data.errors }
  }
}
</script>
<style lang="scss" scoped>
</style>
