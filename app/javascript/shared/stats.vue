<template>
  <div class="stats">
    <a :href="`http://localhost:3000/users/${current_user.id}/following`">
      <strong id="following" class="stat">{{ current_user.following }}</strong>
      following
    </a>
    <a :href="`http://localhost:3000/users/${current_user.id}/followers`">
      <strong id="followers" class="stat">{{ current_user.followers }}</strong>
      followers
    </a>
  </div>
</template>

<script>
export default {
  name: 'stats',
  props: {
    current_user: {
      type: Object,
      required: true,
    },
  },
};
</script>