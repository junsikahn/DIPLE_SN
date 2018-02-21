<template>
  <table class="table table-bordered">
    <thead class="thead-default">
      <tr>
        <th class="text-center">문제</th>
      </tr>
    </thead>
    <tbody class="text-center">
      <tr v-if="loading">
        <td class="p-5 text-muted">loading...</td>
      </tr>
      <tr v-else-if="error">
        <td class="p-5 text-muted">{{ error }}</td>
      </tr>
      <tr v-else-if="problems.length == 0">
        <td class="p-5 text-muted">포함된 문제가 없습니다</td>
      </tr>
      <tr v-else=""
          v-for="(problem, order) in problems"
          :key="problem.id">
        <td>
          <problem :problem="problem" :order="order + 1"></problem>
        </td>
      </tr>
    </tbody>
  </table>
</template>
<script>
import Problem from './Problem'
export default {
  name: "Problems",
  components: {
    Problem
  },
  data () {
    return {
      loading: false,
      error: null,
      problems: []
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.error = null
      this.loading = true
      this.problems = []
      axios.get(`${this.$route.path}.json`)
        .then((response) => {
          this.loading = false
          this.problems = response.data
        }).catch((error) => {
          this.error = error.toString()
        })
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
