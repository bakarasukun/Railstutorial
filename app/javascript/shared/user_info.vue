<template>
  <div id="user_info">
    <a :href="`http://localhost:3000/users/${current_user.id}`">
      <img :src="`${current_user.avatar}`" />
    </a>
    <h1>{{ current_user.name }}</h1>
    <span>
      <a :href="`http://localhost:3000/users/${current_user.id}`">View my profile</a>
    </span>
    <span>{{ pluralize(current_user.microposts_count) }}</span>
  </div>
</template>

<script>
export default {
  name: 'user_info',
  props: {
    current_user: {
      type: Object,
      required: true,
    },
  },
  methods: {
    pluralize(count) {
      if (count === 1) {
        return count + ' micropost';
      } else {
        return count + ' microposts';
      }
    },
  },
};
</script>