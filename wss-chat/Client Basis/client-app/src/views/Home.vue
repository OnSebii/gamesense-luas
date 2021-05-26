<template>
  <div>
    <h4 v-if="message != null" class="altert alert-danger text-center">
      {{ message }}
    </h4>
  </div>
</template>

<script>
export default {
  data() {
    return {
      ws: null,
      message: null,
    };
  },
  created() {
    this.ws = new WebSocket('ws://localhost:3000');
    this.ws.onmessage = ({ data }) => {
      this.message = data;
    };
  },
};
</script>
