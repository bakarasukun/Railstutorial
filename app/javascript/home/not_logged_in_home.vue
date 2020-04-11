<template>
  <div id="not_logged_in_home">
    <div class="center jumbotron">
      <h1>Welcome to the Sample App</h1>
      <h2>
        This is the home page for the
        <a href="http://railstutorial.jp/">Ruby on Rails Tutorial</a>
        sample application.
      </h2>
      <el-button
        type="primary"
        @click="window.location.href = `http://localhost:3000/signup`"
      >Sign up now!</el-button>
    </div>
    <a href="http://rubyonrails.org/">
      <img src="../../assets/images/rails.png" alt="Rails logo" />
    </a>
  </div>
</template>

<script>
export default {
  name: 'not-logged-in-home',
};
</script>
