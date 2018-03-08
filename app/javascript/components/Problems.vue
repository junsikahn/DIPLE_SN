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
  data: () => ({
    loading: false,
    error: null,
    problems: []
  }),
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
      this.axios.get(`api${this.$route.path}.json`)
        .then((res) => {
          this.loading = false
          this.problems = res.data
        }).catch((err) => {
          this.error = err.toString()
        })
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
