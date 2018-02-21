<template>
  <main>
    <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
      <div class="container">
        <router-link class="navbar-brand" :to="{ name: 'Index' }">OMRice</router-link>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <router-link class="nav-link" :to="{ name: 'Problems' }">ProblemList</router-link>
          </ul>
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="/admin">어드민</a>
            </li>
            <!-- <li class="nav-item">
              <% if current_user %>
                <%= link_to '로그아웃', destroy_user_session_path, class: 'nav-link', method: :delete %>
              <% else %>
                <%= link_to '로그인', new_user_session_path, class: 'nav-link' %>
              <% end %>
            </li> -->
          </ul>
        </div>
      </div>
    </nav>
    <section class="container-fluid pt-3 pb-5 d-flex justify-content-center align-items-center">
      <div class="container">
        <router-view></router-view>
      </div>
    </section>
  </main>
</template>
<script>
export default {
  name: 'app',
  data: () => ({
  })
}
</script>
<style lang="scss" scoped>
section { min-height: calc(100vh - 56px); }
</style>
